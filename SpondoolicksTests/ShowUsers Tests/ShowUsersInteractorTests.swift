//
//  Tests functionality of the Show Users Interactor
//
//  Created by Andrew Johnson on 24/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import XCTest
@testable import Spondoolicks

class ShowUsersInteractorTests: XCTestCase {
    
    // MARK: - Properties
    var sut: ShowUsersInteractor!
    
    //MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        
        sut = ShowUsersInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInteractorCallsWorkerToFindUsers() {
        // Given
        let worker = ShowUsersWorkerSpy()
        sut.worker = worker
        
        // When
        sut.findUsers(request: ShowUsers.FindUsers.Request())
        
        // Then
        XCTAssertTrue(worker.findUsersCalled, "Show Users Interactor did not call the Worker to Find Users.")
    }
    
    func testStoresFoundUsers() {
        // Given
        let testData = TempUser(userId: 1, userName: "Andrew", avatarImage: "0")
        
        // When
        sut.usersFound(users: [testData])
        
        // Then
        XCTAssertNotNil(sut.users, "Show Users Interactor did not store retrieved Users after Find Users.")
    }
    
    func testInteractorCallsPresenterWithFindUserResults() {
        // Given
        let presenter = ShowUsersPresenterSpy()
        sut.presenter = presenter
        
        // When
        sut.usersFound(users: [])
        
        // Then
        XCTAssertTrue(presenter.presentFoundUsersCalled, "Show Users Interactor did not call Presenter with Find User results.")
    }
    
    func testInteractorCallsWorkerToDeleteUser() {
        // Given
        let worker = ShowUsersWorkerSpy()
        sut.worker = worker
        
        // When
        sut.deleteUser(request: ShowUsers.DeleteUser.Request(userId: 0))
        
        // Then
        XCTAssertTrue(worker.deleteUserCalled, "Show Users Interactor did not call the Worker to Delete User.")
    }
    
    func testInteractorCallsPresenterWithDeleteUserResult() {
        // Given
        let presenter = ShowUsersPresenterSpy()
        sut.presenter = presenter
        
        // When
        sut.userDeleted(newUsers: [], error: nil)
        
        // Then
        XCTAssertTrue(presenter.presentDeleteUserCalled, "Show Users Interactor did not call Presenter with Delete User result.")
    }
    
    func testDeleteUserRemovesUserFromLocalStore() {
        // Given
        let testData = ShowUsersWorker().createTestUsers()
        var updatedTestData = ShowUsersWorker().createTestUsers()
        updatedTestData.remove(at: 0)
        sut.users = testData
        
        // When
        sut.userDeleted(newUsers: updatedTestData, error: nil)
        
        // Then
        XCTAssertTrue(sut.users! == updatedTestData, "Show Users Interactor did not remove the deleted user from its local store.")
    }
    
    // MARK: - Test doubles
    class ShowUsersWorkerSpy: ShowUsersWorker {
        var findUsersCalled = false
        var deleteUserCalled = true
        
        override func findUsers(callback: @escaping ShowUsersWorker.userCallback) {
            findUsersCalled = true
        }
        
        override func deleteUser(userId: Int, callback: @escaping ShowUsersWorker.errorCallback) {
            deleteUserCalled = true
        }
    }
    
    class ShowUsersPresenterSpy: ShowUsersPresenter {
        var presentFoundUsersCalled = false
        var presentDeleteUserCalled = false
        
        override func presentFoundUsers(response: ShowUsers.FindUsers.Response) {
            presentFoundUsersCalled = true
        }
        
        override func presentDeleteUserResult(response: ShowUsers.DeleteUser.Response) {
            presentDeleteUserCalled = true
        }
    }
}
