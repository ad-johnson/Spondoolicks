//
//  Created by Andrew Johnson on 12/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import XCTest

@testable import Spondoolicks

class AddParentViewControllerTests: XCTestCase {
    
    // MARK: - Properties
    var sut: AddParentViewController! = nil
    
    // MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        
        // Instantiate the View Controller for all tests
        let storyboard = UIStoryboard(name: Global.Identifier.Storyboard.MAIN, bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: Global.Identifier.ViewController.ADD_PARENT_VC)
            as! AddParentViewController
        let _ = sut.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Unit tests
    func testVCVIPCycleEstablished() {
        // Given
        
        // When
        let interactor = sut.interactor as! AddParentInteractor
        let presenter = interactor.presenter as! AddParentPresenter
        let vc = presenter.viewController as! AddParentViewController
        let router = sut.router as! AddParentRouter
        let datastore = router.dataStore
        
        // Then
        XCTAssertNotNil(interactor, "VC did not setup a link to the Interactor.")
        XCTAssertNotNil(presenter, "VC did not setup a link between the Interactor and Presenter.")
        XCTAssertNotNil(vc, "VC did not setup a link between the Presenter and View Controller.")
        XCTAssertNotNil(router, "VC did not setup a link to the Router.")
        XCTAssertNotNil(datastore, "VC did not setup a link between the Router and Interactor.")
        XCTAssertTrue(sut === vc, "VC did not complete the VIP cycle back to itself.")
    }
    
    func testVCSaveButtonConnected() {
        // Given
        // When
        // Then
        XCTAssertNotNil(sut.saveButton, "AddParent VC did not have a connected Save Button.")
    }
    
    func testVCParentTextLabelConnected() {
        // Given
        // When
        // Then
        XCTAssertNotNil(sut.saveButton, "AddParent VC did not have a connected Parent Text Label.")
    }
    
    func testVCHelpButtonConnected() {
        // Given
        // When
        // Then
        XCTAssertNotNil(sut.saveButton, "AddParent VC did not have a connected Help Button.")
    }
    
    func testVCSaveButtonHasAction() {
        // Given
        let saveButton = sut.saveButton!
        
        //When

        // Then
        if let action = saveButton.action {
            XCTAssertTrue(action.description == "saveTapped:",
                          "The AddParent VC Save button is not connected to the right action")
        } else {
            XCTFail("The AddParent VC Save button has no actions connected")
        }
    }
    
    func testVCHelpButtonHasAction() {
        // Given
        let helpButton = sut.helpButton!
        
        //When
        
        // Then
        if let action = helpButton.action {
            XCTAssertTrue(action.description == "helpTapped:",
                          "The AddParent VC Help button is not connected to the right action")
        } else {
            XCTFail("The AddParent VC Help button has no actions connected")
        }
    }
    
    func testVCSaveButtonIsDisabledAtStartup() {
        // Given
        let button = sut.saveButton!
        
        // When
        //Then
        XCTAssertFalse(button.isEnabled, "AddParent VC enabled the Save button at startup.")
    }
    
    func testVCSaveButtonIsEnabledWhenPinChanged() {
        // Given
        
        // When
        sut.newPinSelected("1234")
        
        // Then
        XCTAssertTrue(sut.saveButton.isEnabled, "AddParent VC did not enable the Save button when pin changed.")
    }
    
    func testVCNewPinStoredWhenPinChanged() {
        // Given
        
        // When
        sut.newPinSelected("1234")
        
        // Then
        XCTAssertTrue(sut.currentPin == "1234", "AddParent VC did not store the pin when it was changed.")
    }
    
    func testVCCallsInteractorToAddParent() {
        // Given
        let interactor = AddParentInteractorSpy()
        sut.interactor = interactor
        sut.currentPin = "1234"

        // When
        sut.addParent()
        
        // Then
        XCTAssertTrue(interactor.addParentCalled, "AddParent VC did not call the Interactor to Add Parent.")
    }
    
    // MARK - Test doubles
    class AddParentInteractorSpy: AddParentInteractor {
        var addParentCalled = false
        
        override func addParent(request: AddParent.AddParent.Request) {
            addParentCalled = true
        }
    }
    
}
