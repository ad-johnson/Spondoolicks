//
//  Created by Andrew Johnson on 12/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import XCTest
@testable import Spondoolicks

class AddParentInteractorTests: XCTestCase {
    
    // MARK: - Properties
    var sut: AddParentInteractor!
    
    //MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        
        sut = AddParentInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Unit tests
    func testInteractorCallsWorkerToAddUser() {
        // Given
        let worker = AddParentWorkerSpy()
        sut.worker = worker
        
        // When
        sut.addParent(request: AddParent.AddParent.Request(newPin: "1234"))
        
        // Then
        XCTAssertTrue(worker.addParentCalled, "AddParent Interactor did not call Worker to add a parent.")
    }
    
    func testInteractorDoesNotHoldParentAtStartup() {
        // Given
        // When
        // Then
        XCTAssertNil(sut.parent, "AddParent Interactor has a parent instance at startup.")
    }

    func testInteractorCallsPresenterToDisplayAddParentResult() {
        // Given
        let presenter = AddParentPresenterSpy()
        sut.presenter = presenter
        
        // When
        sut.parentAdded(Parent())

        // Then
        XCTAssertTrue(presenter.presentAddParentResultCalled, "AddParent Interactor did not call Presenter with result of adding a parent.")
    }
    
    func testInteractorStoresNewParent() {
        // Given
        
        // When
        sut.parentAdded(Parent())
        
        // Then
        XCTAssertNotNil(sut.parent, "AddParent Interactor did not store the added parent.")
    }
    
    // MARK: - Test doubles
    class AddParentWorkerSpy: AddParentWorker {
        var addParentCalled = false
        override func addParent(newPin: String, completion: @escaping (Parent) -> ()) {
            addParentCalled = true
        }
    }
    
    class AddParentPresenterSpy: AddParentPresenter {
        var presentAddParentResultCalled = false
        
        override func presentAddParentResult(response: AddParent.AddParent.Response) {
            presentAddParentResultCalled = true
        }
    }
}
