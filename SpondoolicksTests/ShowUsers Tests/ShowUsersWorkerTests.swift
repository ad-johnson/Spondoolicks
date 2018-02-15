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
    var cdm: CoreDataManagerMock!
    var users: [User]!

    //MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        
        sut = ShowUsersWorker()
        if cdm == nil {
            cdm = CoreDataManagerMock.initialiseForTest()
        }
        sut.coreDataManager = cdm
        users = cdm.addUsersForTest()
    }
    
    override func tearDown() {
        super.tearDown()
        users = nil
        cdm.deleteUsersForTest()
    }

    // MARK: - Unit tests
    func testWorkerCallsInteractorWithFindUsersResults() {
        // Given
        let interactor = ShowUsersInteractorMock()
        let expectation = XCTestExpectation(description: "Wait on callback")
        interactor.expectation = expectation
        
        // When
        let cdmExpectation = XCTestExpectation(description: "Wait on Core Data")
        cdm.expectation = cdmExpectation
        sut.findUsers(completion: interactor.usersFound)
        let _ = XCTWaiter.wait(for: [cdmExpectation, expectation], timeout: 5)
        
        // Then
        XCTAssertTrue(interactor.usersFoundCalled, "Show Users Worker did not call the Interactor with the Find Users results.")
        XCTAssertTrue(interactor.isUsersValid(expected: 3), "Show Users Worker did not call the Interactor with the right number of Find Users results.")
    }
    
    func testCallsInteractorWithDeleteUserResult() {
        // Given
        let interactor = ShowUsersInteractorMock()
        
        // When
        let user = users[0]
        let cdmExpectation = XCTestExpectation(description: "Wait on DeleteUsers")
        cdm.expectation = cdmExpectation
        let expectation = XCTestExpectation(description: "Wait on callback")
        interactor.expectation = expectation
        sut.deleteUser(user, id: 0, completion: interactor.userDeleted)
        let _ = XCTWaiter.wait(for: [cdmExpectation, expectation], timeout: 5)
        // Then
        XCTAssertTrue(interactor.userDeletedCalled, "Show Users Worker did not call the Interactor with Delete User results.")
        XCTAssertTrue(interactor.isExpectedIdValid(expected: 0), "Show Users Worker did not call the Interactor with the right number of Find Users results.")
   }
    
    // MARK: - Test doubles
    class ShowUsersInteractorMock: ShowUsersInteractor {
        var usersFoundCalled = false
        var userDeletedCalled = false
        var expectedId = -1
        var expectation: XCTestExpectation?
        
        override func usersFound(users: [User]) {
            usersFoundCalled = true
            self.users = users
            expectation?.fulfill()
        }
        override func userDeleted(success: Bool, id: Int) {
            userDeletedCalled = true
            expectedId = id
            expectation?.fulfill()
       }
        
        func isUsersValid(expected: Int) -> Bool {
            guard users != nil else { return false }
            return users?.count == expected ? true : false
        }
        
        func isExpectedIdValid(expected: Int) -> Bool {
            return expectedId == expected ? true : false
        }
    }
}
