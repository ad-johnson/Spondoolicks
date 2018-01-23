//
//  SpondoolicksUITests.swift
//  SpondoolicksUITests
//
//  Created by Andrew Johnson on 17/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import XCTest

class SpondoolicksUITests: XCTestCase {
    // MARK: - Properties
    var app: XCUIApplication!
    
    // MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
     }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShowUsers() {
        // Given
        
        // When
        let homeTitle = app.navigationBars.firstMatch.identifier
        app.tables.cells.staticTexts["Users"].tap()
        let navigatedTitle = app.navigationBars.firstMatch.identifier
        
        // Then
        XCTAssertTrue(homeTitle == "Home", "Application Home UI has the wrong title.")
        XCTAssertTrue(navigatedTitle == "Users", "Application did not navigate to Users view when selection made.")
    }
    
    func testShowSettings() {
        // Given
        
        // When
        app.tables.cells.staticTexts["Settings"].tap()
        let navigatedTitle = app.navigationBars.firstMatch.identifier
        // Then
        XCTAssertTrue(navigatedTitle == "Settings", "Application did not navigate to Settings view when selection made.")
    }

}
