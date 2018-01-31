//
//  ShowUsersWorkerTests.swift
//  SpondoolicksTests
//
//  Created by Andrew Johnson on 25/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import XCTest
@testable import Spondoolicks

class ShowUsersWorkerTests: XCTestCase {
    
    // MARK: - Properties
    var sut: ShowUsersWorker!
    
    //MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        
        sut = ShowUsersWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Unit tests
    func testWorkerCallsInteractorWithFindUsersResults() {
        // Given
        let interactor = ShowUsersInteractorSpy()
        let expectation = XCTestExpectation(description: "Wait on callback")
        interactor.expectation = expectation
        
        // When
        sut.findUsers(callback: interactor.usersFound)
        let _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        
        // Then
        XCTAssertTrue(interactor.usersFoundCalled, "Show Users Worker did not call the Interactor with Find Users results.")
    }
    
    func testCallsInteractorWithDeleteUserResult() {
        // Given
        let interactor = ShowUsersInteractorSpy()
        let expectation = XCTestExpectation(description: "Wait on callback")
        interactor.expectation = expectation
        
        // When
        sut.deleteUser(userId: 0, callback: interactor.userDeleted)
        let _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        
        // Then
        XCTAssertTrue(interactor.userDeletedCalled, "Show Users Worker did not call the Interactor with Delete User results.")
    }
    
    // MARK: - Test doubles
    class ShowUsersInteractorSpy: ShowUsersInteractor {
        var usersFoundCalled = false
        var userDeletedCalled = false
        var expectation: XCTestExpectation?
        
        override func usersFound(users: [TempUser]) {
            usersFoundCalled = true
            expectation?.fulfill()
        }
        
        override func userDeleted(newUsers: [TempUser], error: Error?) {
            userDeletedCalled = true
        }
    }
}
