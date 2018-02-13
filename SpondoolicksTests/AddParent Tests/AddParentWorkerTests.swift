//
//  AddParentWorkerTests.swift
//  SpondoolicksTests
//
//  Created by Andrew Johnson on 12/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import XCTest
@testable import Spondoolicks

class AddParentWorkerTests: XCTestCase {
    
    // MARK: - Properties
    var sut: AddParentWorker!
    var cdm: CoreDataManagerMock!
    
    //MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        
        sut = AddParentWorker()
        
        cdm = CoreDataManagerMock()
        let expectation = XCTestExpectation(description: "Wait for Core Data initialisation")
        cdm.initialiseStack { expectation.fulfill() }
        _ = XCTWaiter.wait(for: [expectation], timeout: 5)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Unit tests
    func testWorkerHasCoreDataManagerAtStartup() {
        // Given
        // When
        // Then
        XCTAssertNotNil(sut.coreDataManager, "AddParent Worker did not have a reference to CoreDataManager at startup.")
    }

    func testWorkerCallsCoreDataManagerToAddParent() {
        // Given
        let (interactor, expectation) = setupTest()

        // When
        sut.addParent(newPin: "1234", completion: interactor.parentAdded)
        _ = XCTWaiter.wait(for: [expectation], timeout: 5)

        // then
        XCTAssertTrue(cdm.identifier == "AddParent", "AddParent Worker did not call Core Data Manager to perform the AddParent action.")
    }
    
    func testWorkerCallsInteractorWithResultOfAddParent() {
        // Given
        let (interactor, expectation) = setupTest()

        // When
        sut.addParent(newPin: "1234", completion: interactor.parentAdded)
        _ = XCTWaiter.wait(for: [expectation], timeout: 5)

        // then
        XCTAssertTrue(interactor.isParentValid(expectedPin: "1234"), "AddParent Worker did not Add the parent correctly.")
    }
    
    // Mark: - Helper methods
    func setupTest() -> (AddParentInteractorMock, XCTestExpectation) {
        let interactor = AddParentInteractorMock()
        let expectation = XCTestExpectation(description: "Wait for callback")
        cdm.expectation = expectation
        sut.coreDataManager = cdm
        return (interactor, expectation)
    }
    
    // MARK: - Test doubles
    class AddParentInteractorMock: AddParentInteractor {
        
        override func parentAdded(_ parent: Parent) {
            self.parent = parent
        }
        
        func isParentValid(expectedPin: String) -> Bool {
            guard parent != nil else { return false }
            return parent?.pin == expectedPin
        }
    }
}
