//
//  MaintainUserWorkerTests.swift
//  SpondoolicksTests
//
//  Created by Andrew Johnson on 30/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import XCTest
@testable import Spondoolicks

class MaintainUserWorkerTests: XCTestCase {
    
    // MARK: - Properties
    var sut: MaintainUserWorker!
    var cdm: CoreDataManagerMock!
    var users: [User]!
    
    //MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        
        sut = MaintainUserWorker()
        if cdm == nil {
            cdm = CoreDataManagerMock.initialiseForTest()
        }
        sut.coreDataManager = cdm
        users = cdm.addUsersForTest()
    }
    
    override func tearDown() {
        super.tearDown()
        cdm.deleteUsersForTest()
    }
    
    // MARK: - Unit tests
    func testWorkerCallsInteractorWithAddUserResult() {
        // Given
        let interactor = setupUpdateCallbackTests()
        
        // When
        let cdmExpectation = XCTestExpectation(description: "Wait on Core Data")
        cdm.expectation = cdmExpectation
        sut.addUser(name: "Louise", avatarImage: "1", completion: interactor.userAdded)
        let _ = XCTWaiter.wait(for: [cdmExpectation, interactor.expectation], timeout: 5)

        // Then
        XCTAssertTrue(interactor.userAddedCalled, "MaintainUser Worker did not call Interactor with result of Add User.")
        XCTAssertTrue(interactor.isValidUser(expectedName: "Louise", expectedAvatarImage: "1"), "MaintainUser Worker did not correctly add a User.")
    }
    
    func testWorkerCallsInteractorWithChangeUserResult() {
        // Given
        let interactor = setupUpdateCallbackTests()
        let user = users[0]
        
        // When
        user.name = "Louise"
        sut.changeUser(user, completion: interactor.userUpdated)
        let _ = XCTWaiter.wait(for: [interactor.expectation], timeout: 5)
        
        // Then
        XCTAssertTrue(interactor.userUpdatedCalled, "MaintainUser Worker did not call Interactor with result of Change User.")
        XCTAssertTrue(user.name == "Louise", "MaintainUser Worker did not correctly update the User.")
    }
    
    // MARK: - Helper methods
    func setupUpdateCallbackTests() -> MaintainUserInteractorMock {
        let interactor = MaintainUserInteractorMock()
        let expectation = XCTestExpectation(description: "Await update callback")
        interactor.expectation = expectation
        return interactor
    }
    
    // MARK: - Test doubles
    class MaintainUserInteractorMock: MaintainUserInteractor {
        var userUpdatedCalled = false
        var userAddedCalled = false
        var user: User?
        var expectation: XCTestExpectation!
        
        override func userAdded(_ user: User) {
            userAddedCalled = true
            self.user = user
        }
        
        override func userUpdated(_ success: Bool) {
            userUpdatedCalled = success
            expectation.fulfill()
        }
        
        func isValidUser(expectedName: String, expectedAvatarImage: String) -> Bool {
            guard user != nil else { return false }
            guard user?.name == expectedName else { return false }
            guard user?.avatarImage == expectedAvatarImage else { return false }
            return true
        }
    }
}
