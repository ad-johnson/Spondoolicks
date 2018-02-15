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
    var cdm: CoreDataManagerMock!
    var users: [User]!
    
    //MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        
        sut = ShowUsersInteractor()
        if cdm == nil {
            cdm = CoreDataManagerMock.initialiseForTest()
        }
        sut.worker.coreDataManager = cdm
        users = cdm.addUsersForTest()
    }
    
    override func tearDown() {
        super.tearDown()
        cdm.deleteUsersForTest()
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
        
        // When
        sut.usersFound(users: users)
        
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
        sut.deleteUser(request: ShowUsers.DeleteUser.Request(userName: "Andrew"))
        
        // Then
        XCTAssertTrue(worker.deleteUserCalled, "Show Users Interactor did not call the Worker to Delete User.")
    }
    
    func testInteractorCallsPresenterWithDeleteUserResult() {
        // Given
        let presenter = ShowUsersPresenterSpy()
        sut.presenter = presenter
        
        // When
        sut.userDeleted(success: true, id: 0)
        
        // Then
        XCTAssertTrue(presenter.presentDeleteUserCalled, "Show Users Interactor did not call Presenter with Delete User result.")
    }
    
    func testDeleteUserRemovesUserFromLocalStore() {
        // Given
        let startUserCount = users?.count
        sut.users = users
        
        // When
        sut.userDeleted(success: true, id: 0)
        
        // Then
        XCTAssertTrue(sut.users?.count == startUserCount! - 1, "Show Users Interactor did not remove the deleted user from its local store.")
    }
    
    func testInteractorPassesErrorToPresenterForDeleteUser() {
        // Given
        let presenter = ShowUsersPresenterFake()
        let expectation = XCTestExpectation(description: "Wait for Delete User callback.")
        presenter.expectation = expectation
        sut.presenter = presenter
        sut.users = users
        
        // When
        sut.deleteUser(request: ShowUsers.DeleteUser.Request(userName: "Bob"))
        let _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        
        // Then
        XCTAssertNotNil(presenter.result.error, "Show Users Interactor did not pass an error to the Presenter when incorrect user deleted.")
    }
    
    // MARK: - Test doubles
    class ShowUsersWorkerSpy: ShowUsersWorker {
        var findUsersCalled = false
        var deleteUserCalled = true
        
        override func findUsers(completion: @escaping ([User]) -> ()) {
            findUsersCalled = true
        }
        
        override func deleteUser(_ user: User, id: Int, completion: @escaping (Bool, Int) -> ()) {
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
    
    class ShowUsersPresenterFake: ShowUsersPresenter {
        var result = ShowUsers.DeleteUser.Response(error: nil)
        var expectation: XCTestExpectation?
        
        override func presentDeleteUserResult(response: ShowUsers.DeleteUser.Response) {
            result = response
            expectation?.fulfill()
        }
    }
}
