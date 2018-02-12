//
//  ResultModalControllerTests.swift
//  SpondoolicksTests
//
//  Created by Andrew Johnson on 12/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import XCTest
@testable import Spondoolicks

class ResultModalControllerTests: XCTestCase {
    
    // MARK: - Properties
    var sut: ResultModalViewController! = nil
    
    // MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        
        // Instantiate the View Controller for all tests
        sut = ResultModalViewController()
        let _ = sut.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Unit tests
    func testVCHasResultLabelConnected() {
        // Given
        // When
        // Then
        XCTAssertNotNil(sut.result, "ResultModal VC does not have a connected Result label.")
    }
    
    func testVCHasIndicatorConnected() {
        // Given
        // When
        // Then
        XCTAssertNotNil(sut.indicator, "ResultModal VC does not have a connected Indicatore Image View.")
    }
    func testVCHasPanelViewConnected() {
        // Given
        // When
        // Then
        XCTAssertNotNil(sut.panelView, "ResultModal VC does not have a connected Panel View.")
    }
    
    func testVCHasDefaultsForSuccessAtLaunch() {
        // Given
        // When
        sut.viewDidLoad()
        
        // THen
        XCTAssertTrue(sut.success, "ResultModal VC does not default to showing a success result.")
        XCTAssertTrue(sut.duration == 2.0, "ResultModal VC does not default to showing success for 2 seconds.")
        XCTAssertNil(sut.timer, "ResultModal VC has set a timer to run on launch by default.")
        XCTAssertNil(sut.completion, "ResultModal VC is providing its own default completion handler.")
    }
    
    func testVCSetsupForSuccess() {
        // Given
        // When
        // Then
        XCTAssertTrue(sut.result.text == "Success", "ResultModal is not showing Success in the label.")
        XCTAssertNotNil(sut.indicator.image, "ResultModal did not load an image to show Success.")
    }
    
    func testVCSetsupForFailure() {
        // Given
        let tempSut = ResultModalViewController()
        tempSut.success = false
        let _ = tempSut.view

        // When
        tempSut.viewDidLoad()
        
        // Then
        XCTAssertTrue(tempSut.result.text! == "Failed", "ResultModal is not showing Failure in the label \(tempSut.result.text!).")
        XCTAssertNotNil(tempSut.indicator.image, "ResultModal did not load an image to show Failure.")
    }
}
