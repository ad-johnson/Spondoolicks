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

    func testVCHasAddButtonConnected() {
        // Given
        
        // When
        
        // Then
        XCTAssertNotNil(sut.addButton, "Show Users VC does not have a connected Add button.")
    }
    
    func testSaveButtonHasTheCorrectAction() {
        // Given
        let button = sut.addButton
        let action = button?.action
        
        // When
        
        // Then
        XCTAssertTrue(action?.description == "addUserTapped:", "Show Users VC has not connected the Add button to the right action.")
    }
    
    func testVCHasHelpButtonConnected() {
        // Given
        
        // When
        
        // Then
        XCTAssertNotNil(sut.helpButton, "Show Users VC does not have a connected help button.")
    }
    
    func testHelpButtonHasTheCorrectAction() {
        // Given
        let button = sut.helpButton
        let action = button?.action
        
        // When
        
        // Then
        XCTAssertTrue(action?.description == "helpTapped:", "Show Users VC has not connected the Help button to the right action.")
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
        let vc = ShowUsersViewControllerInterceptor()
        let expectation = setupFindUsersTest(interceptor: vc)
        // When
        sut.findUsers()
        let _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        
        // Then
        XCTAssertTrue(testUsers == sut.displayedUsers, "Find Users functionality did not return the correct data.")
    }
    
    func testVCCallsInteractorToDeleteUser() {
        // Given
        let interactor = ShowUsersInteractorSpy()
        let user = ShowUsers.FindUsers.ViewModel.DisplayedUser(userId: 0, userName: "Andrew", avatarImage: "0")
        sut.displayedUsers.append(user)
        sut.interactor = interactor
        sut.userBeingActioned = IndexPath(row: 0, section: 0)
        
        // When
        sut.deleteUser(alertAction: nil)
        
        // Then
        XCTAssertTrue(interactor.deleteUserCalled, "Show Users VC did not call Interactor to Delete User.")
    }
    
    // MARK: - Integration tests
    func testDeleteUserRemovesRowFromTableView() {
        // Given
        let vc = ShowUsersViewControllerInterceptor()
        var expectation = setupFindUsersTest(interceptor: vc)

        // When
        sut.findUsers()
        let _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        
        let rowCount = sut.userTable.numberOfRows(inSection: 0)
        sut.userBeingActioned = IndexPath(row: 0, section: 0)
        expectation = XCTestExpectation(description: "Wait for DeleteUser completion")
        vc.expectation = expectation
        sut.deleteUser(alertAction: nil)
        let _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        let newNumberofRows = sut.userTable.numberOfRows(inSection: 0)
        
        // Then
        XCTAssertTrue(newNumberofRows == rowCount - 1, "Show Users VC did not remove a deleted user from the Table View.")
    }
    
    func testDeleteUserRemovesUserFromLocallyStoredUsers() {
        // Given
        let vc = ShowUsersViewControllerInterceptor()
        var expectation = setupFindUsersTest(interceptor: vc)
        
        // When
        sut.findUsers()
        let _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        
        let userCount = sut.displayedUsers.count
        sut.userBeingActioned = IndexPath(row: 0, section: 0)
        expectation = XCTestExpectation(description: "Wait for DeleteUser completion")
        vc.expectation = expectation
        sut.deleteUser(alertAction: nil)
        let _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        let newNumberofUsers = sut.displayedUsers.count
        
        // Then
        XCTAssertTrue(newNumberofUsers == userCount - 1, "Show Users VC did not remove a deleted user from the locally held store of users.")
    }
    
    func testErrorHandledWhenIncorrectUserDeleted() {
        // Given
        let testData = ShowUsers.FindUsers.ViewModel.DisplayedUser(userId: 1, userName: "Andrew", avatarImage: "0")
        let sutFake = ShowUsersViewControllerFake()
        sutFake.displayedUsers = [testData]
        sutFake.userBeingActioned = IndexPath(row: 0, section: 0)
        
        // When
        // userDeleted is inherited and thus the 'real' code is executed
        sutFake.userDeleted(viewModel: ShowUsers.DeleteUser.ViewModel(error: Global.Errors.UserMaintenanceError.userNotFound))
        
        // Then
        XCTAssertTrue(sutFake.displayErrorCalled, "Show Users VC did not display the Delete User error.")
    }
    
    func testNoLocalUsersRemovedWhenDeleteUserErrorReceived() {
        // Given
        let testData = ShowUsers.FindUsers.ViewModel.DisplayedUser(userId: 1, userName: "Andrew", avatarImage: "0")
        sut.displayedUsers = [testData]
        sut.userBeingActioned = IndexPath(row: 0, section: 0)
        
        // When
        // userDeleted is inherited and thus the 'real' code is executed
        sut.userDeleted(viewModel: ShowUsers.DeleteUser.ViewModel(error: Global.Errors.UserMaintenanceError.userNotFound))
        
        // Then
        XCTAssertTrue(sut.displayedUsers.count == 1, "Show Users VC deleted a user from local store when Delete User error received.")
    }
    
    // MARK: - Helper methods
    func generateTestUsers() -> [ShowUsers.FindUsers.ViewModel.DisplayedUser] {
        var testData = [ShowUsers.FindUsers.ViewModel.DisplayedUser]()
        let testUsers = TempUser.users
        for user in testUsers {
            let displayedUser = ShowUsers.FindUsers.ViewModel.DisplayedUser(userId: user.userId, userName: user.userName, avatarImage: user.avatarImage)
            testData.append(displayedUser)
        }
        return testData
    }
    
    func setupFindUsersTest(interceptor: ShowUsersViewControllerInterceptor) -> XCTestExpectation {
        let expectation = XCTestExpectation(description: "Wait for FindUsers completion")
        let interactor = sut.interactor as! ShowUsersInteractor
        let presenter = interactor.presenter as! ShowUsersPresenter
        presenter.viewController = interceptor
        interceptor.expectation = expectation
        interceptor.sut = sut
        return expectation
    }

    // MARK: - Test doubles
    class ShowUsersInteractorSpy: ShowUsersInteractor {
        var findUsersCalled = false
        var deleteUserCalled = false
        
        override func findUsers(request: ShowUsers.FindUsers.Request) {
            findUsersCalled = true
        }
        
        override func deleteUser(request: ShowUsers.DeleteUser.Request) {
            deleteUserCalled = true
        }
    }
    
    class ShowUsersViewControllerInterceptor: ShowUsersViewController {
        var expectation: XCTestExpectation?
        var sut: ShowUsersViewController?
        
        override func displayUsers(viewModel: ShowUsers.FindUsers.ViewModel) {
            sut?.displayUsers(viewModel: viewModel)
            expectation?.fulfill()
        }
        
        override func userDeleted(viewModel: ShowUsers.DeleteUser.ViewModel) {
            sut?.userDeleted(viewModel: viewModel)
            expectation?.fulfill()
        }
    }
    
    class ShowUsersViewControllerFake: ShowUsersViewController {
        var displayErrorCalled = false

        override func displayError(_ message: String) {
            displayErrorCalled = true
        }
    }
}
