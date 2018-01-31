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
    
    //MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        
        sut = MaintainUserWorker()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Unit tests
    func testWorkerCallsInteractorWithAddUserResult() {
        // Given
        let (interactor, user) = setupUpdateCallbackTests()
        
        // When
        sut.addUser(user: user, callback: interactor.userUpdated)
        let _ = XCTWaiter.wait(for: [interactor.expectation], timeout: 5)
        
        // Then
        XCTAssertTrue(interactor.userUpdatedCalled, "Maintain User Worker did not call Interactor with result of Add User.")
    }
    
    func testWorkerCallsInteractorWithChangeUserResult() {
        // Given
        let (interactor, user) = setupUpdateCallbackTests()
        
        // When
        sut.changeUser(user: user, callback: interactor.userUpdated)
        let _ = XCTWaiter.wait(for: [interactor.expectation], timeout: 5)
        
        // Then
        XCTAssertTrue(interactor.userUpdatedCalled, "Maintain User Worker did not call Interactor with result of Change User.")
    }
    
    // MARK: - Helper methods
    func setupUpdateCallbackTests() -> (MaintainUserInteractorSpy, TempUser) {
        let interactor = MaintainUserInteractorSpy()
        let user = TempUser(userId: 0, userName: "Test", avatarImage: "Test")
        let expectation = XCTestExpectation(description: "Await update callback")
        interactor.expectation = expectation
        return (interactor, user)
    }
    
    // MARK: - Test doubles
    class MaintainUserInteractorSpy: MaintainUserInteractor {
        var userUpdatedCalled = false
        var expectation: XCTestExpectation!
        
        override func userUpdated(error: Error?) {
            userUpdatedCalled = true
            expectation.fulfill()
        }
    }
}
