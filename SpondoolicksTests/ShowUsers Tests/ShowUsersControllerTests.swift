//
//  Tests functionality of the Show Users Scene view controller
//
//  Created by Andrew Johnson on 24/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import XCTest
@testable import Spondoolicks

class ShowUsersControllerTests: XCTestCase {
    
    // MARK: - Properties
    var sut: ShowUsersViewController! = nil
    
    // MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        
        // Instantiate the View Controller for all tests
        let storyboard = UIStoryboard(name: Global.Identifier.Storyboard.MAIN, bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: Global.Identifier.ViewController.SHOW_USERS_VC)
            as! ShowUsersViewController
        let _ = sut.view
    }

    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Unit tests
    func testVIPCycleEstablished() {
        // Given
        
        // When
        let interactor = sut.interactor as! ShowUsersInteractor
        let presenter = interactor.presenter as! ShowUsersPresenter
        let vc = presenter.viewController as! ShowUsersViewController
        let router = sut.router as! ShowUsersRouter
        let datastore = router.dataStore
        
        // Then
        XCTAssertNotNil(interactor, "VC did not setup a link to the Interactor.")
        XCTAssertNotNil(presenter, "VC did not setup a link between the Interactor and Presenter.")
        XCTAssertNotNil(vc, "VC did not setup a link between the Presenter and View Controller.")
        XCTAssertNotNil(router, "VC did not setup a link to the Router.")
        XCTAssertNotNil(datastore, "VC did not setup a link between the Router and Interactor.")
        XCTAssertTrue(sut === vc, "VC did not complete the VIP cycle back to itself.")
    }

    func testVCHasAnIntroLabelConnected() {
        // Given
        
        // When
        let intro = sut.introLabel
        
        // Then
        XCTAssertNotNil(intro, "Show Users VC does not have the Introduction label connected.")
    }
    
    func testVCHasTableViewConnected() {
        // Given
        
        // When
        let tableView = sut.userTable
        
        // Then
        XCTAssertNotNil(tableView, "Show Users VC does not have a connected table view.")
    }
    
    func testVCCallsInteractorToFindUsers() {
        // Given
        let interactor = ShowUsersInteractorSpy()
        sut.interactor = interactor
        
        // When
        sut.findUsers()
        
        // Then
        XCTAssertTrue(interactor.findUsersCalled, "Show Users VC did not call Interactor to Find Users when view was setup.")
    }
    
    func testVCStoresDisplayedUsersPassedToIt() {
        // Given
        let response = ShowUsers.FindUsers.ViewModel.init(displayedUsers: generateTestUsers())
        
        // When
        sut.displayUsers(viewModel: response)

        // Then
        XCTAssertFalse(sut.displayedUsers.isEmpty, "Show Users VC is not storing any retrieved Users.")
        XCTAssertTrue(sut.displayedUsers.count == response.displayedUsers.count, "Show Users VC is not storing the correct number of retrieved users.")
    }
    
    func testTableViewHasCorrectNumberOfRows() {
        // Given
        let response = ShowUsers.FindUsers.ViewModel.init(displayedUsers: generateTestUsers())

        // when
        sut.displayUsers(viewModel: response)

        // Then
        XCTAssertTrue(sut.userTable.numberOfRows(inSection: 0) == response.displayedUsers.count, "Show Users Table View is not displaying the right number of retrieved users.")
    }
    
    func testFindUsersReturnsExpectedResults() {
        // Given
        let testUsers = generateTestUsers()
        let expectation = XCTestExpectation(description: "Wait for FindUsers completion")
        let vc = ShowUsersViewControllerMock()
        let interactor = sut.interactor as! ShowUsersInteractor
        let presenter = interactor.presenter as! ShowUsersPresenter
        presenter.viewController = vc
        vc.sut = sut
        
        // When
        sut.findUsers()
        let _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        
        // Then
        XCTAssertTrue(testUsers == sut.displayedUsers, "Find Users functionality did not return the correct data.")
    }
    
    // MARK: - Helper methods
    func generateTestUsers() -> [ShowUsers.FindUsers.ViewModel.DisplayedUser] {
        var testData = [ShowUsers.FindUsers.ViewModel.DisplayedUser]()
        testData.append(ShowUsers.FindUsers.ViewModel.DisplayedUser(userName: "Andrew", avatarImage: "0"))
        testData.append(ShowUsers.FindUsers.ViewModel.DisplayedUser(userName: "David", avatarImage: "1"))
        testData.append(ShowUsers.FindUsers.ViewModel.DisplayedUser(userName: "Katherine", avatarImage: "2"))
        testData.append(ShowUsers.FindUsers.ViewModel.DisplayedUser(userName: "Richard", avatarImage: "3"))
        testData.append(ShowUsers.FindUsers.ViewModel.DisplayedUser(userName: "Rosalind", avatarImage: "4"))
        testData.append(ShowUsers.FindUsers.ViewModel.DisplayedUser(userName: "Stan", avatarImage: "5"))
        testData.append(ShowUsers.FindUsers.ViewModel.DisplayedUser(userName: "Ferdinando De BigName", avatarImage: "6"))
        return testData
    }
    
    // MARK: - Test doubles
    class ShowUsersInteractorSpy: ShowUsersInteractor {
        var findUsersCalled = false
        
        override func findUsers(request: ShowUsers.FindUsers.Request) {
            findUsersCalled = true
        }
    }
    
    class ShowUsersViewControllerMock: ShowUsersViewController {
        var expectation: XCTestExpectation?
        var sut: ShowUsersViewController?
        
        override func displayUsers(viewModel: ShowUsers.FindUsers.ViewModel) {
            sut?.displayUsers(viewModel: viewModel)
            expectation?.fulfill()
        }
    }
}
