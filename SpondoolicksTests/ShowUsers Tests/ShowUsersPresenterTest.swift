//
//  ShowUsersPresenterTest.swift
//  SpondoolicksTests
//
//  Created by Andrew Johnson on 25/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import XCTest
@testable import Spondoolicks

class ShowUsersPresenterTest: XCTestCase {
    
    // MARK: - Properties
    var sut: ShowUsersPresenter!
    var cdm: CoreDataManagerMock!
    var users: [User]!

    //MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        
        sut = ShowUsersPresenter()
        if cdm == nil {
            cdm = CoreDataManagerMock.initialiseForTest()
        }
        users = cdm.addUsersForTest()
    }
    
    override func tearDown() {
        super.tearDown()
        cdm.deleteUsersForTest()
    }

    // MARK: - Unit tests
    func testPresenterCallsVCWithFindUsersResults() {
        // Given
        let vc = ShowUsersViewControllerSpy()
        sut.viewController = vc
        
        // When
        sut.presentFoundUsers(response: ShowUsers.FindUsers.Response(users: users))
        
        // Then
        XCTAssertTrue(vc.displayUsersCalled, "Show Users Presenter did not call VC with results of Find Users.")
    }
    
    func testPresenterCallsVCWithDeleteUserResult() {
        // Given
        let vc = ShowUsersViewControllerSpy()
        sut.viewController = vc
        
        // When
        sut.presentDeleteUserResult(response: ShowUsers.DeleteUser.Response(error: nil))
        
        // Then
        XCTAssertTrue(vc.userDeletedCalled, "Show Users Presenter did not call VC with result of Delete User.")

    }
    
    func testPresenterPassesDeleteUserErrorToVC() {
        // Given
        let response = ShowUsers.DeleteUser.Response(error: Global.Errors.UserMaintenanceError.userNotFound)
        let vc = ShowUsersViewControllerFake()
        sut.viewController = vc
        
        // When
        sut.presentDeleteUserResult(response: response)
        
        // Then
        XCTAssertNotNil(vc.viewModel?.error, "Show Users Presenter did not pass Delete User error to VC.")
    }
    
    // MARK: - Test doubles
    class ShowUsersViewControllerSpy: ShowUsersViewController {
        var displayUsersCalled = false
        var userDeletedCalled = false
        
        override func displayUsers(viewModel: ShowUsers.FindUsers.ViewModel) {
            displayUsersCalled = true
        }
        
        override func userDeleted(viewModel: ShowUsers.DeleteUser.ViewModel) {
            userDeletedCalled = true
        }
    }
    
    class ShowUsersViewControllerFake: ShowUsersViewController {
        var viewModel: ShowUsers.DeleteUser.ViewModel?
        
        override func userDeleted(viewModel: ShowUsers.DeleteUser.ViewModel) {
            self.viewModel = viewModel
        }

        
    }
}
