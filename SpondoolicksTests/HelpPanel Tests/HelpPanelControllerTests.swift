//
//  HelpPanelControllerTests.swift
//  SpondoolicksTests
//
//  Created by Andrew Johnson on 31/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import XCTest
@testable import Spondoolicks

class HelpPanelControllerTests: XCTestCase {
    
    // MARK: - Properties
    var sut: HelpPanelViewController! = nil
    
    // MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        
        // Instantiate the View Controller for all tests
        sut = HelpPanelViewController()
        let _ = sut.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Unit tests
    func testVCHasHeadingLabelConnected() {
        // Given
        
        // When
        
        // Then
        XCTAssertNotNil(sut.helpHeading, "Help Panel VC does not have a connected Heading label.")
    }
    
    func testVCHasTableViewConnected() {
        // Given
        
        // When
        
        // Then
        XCTAssertNotNil(sut.helpEntries, "Help Panel VC does not have a connected Table View.")
    }
    
    func testVCHasPanelViewConnected() {
        // Given
        
        // When
        
        // Then
        XCTAssertNotNil(sut.panelView, "Help Panel VC does not have a connected Panel View.")
    }
    
    func testVCHasBackgroundViewConnected() {
        // Given
        
        // When
        
        // Then
        XCTAssertNotNil(sut.backgroundView, "Help Panel VC does not have a connected BackgroundView.")
    }
    
    func testVCStoresDataSource() {
        // Given
        let dataSource = TestHelperPanelDataSource()
        sut.dataSource = dataSource
        // When
        
        // Then
        XCTAssertNotNil(sut.dataSource, "Help Panel VC did not store the Data Source when given.")
    }
    
    func testVCSetsAlternateTitleWhenNoDataSource() {
        // Given
        sut.dataSource = nil
        
        // When
        sut.setupView()
        
        // Then
        XCTAssertTrue(sut.helpHeading.text == "Missing Title", "Help Panel VC did not set a default Heading when no DataSource connected.")
    }
    
    func testVCObtainsPanelTitleFromDataSource() {
        // Given
        let dataSource = TestHelperPanelDataSource()
        sut.dataSource = dataSource

        // When
        sut.setupView()
        
        // Then
        XCTAssertTrue(sut.helpHeading.text == dataSource.helpPanelTitle(), "Help Panel VC did not retrieve the Panel Heading from the DataSource.")
    }
    
    func testVCObtainsSubheadingsFromDataSource() {
        // Given
        let dataSource = TestHelperPanelDataSource()
        sut.dataSource = dataSource
        
        // When
        sut.setupView()
        
        // Then
        XCTAssertTrue(sut.numberOfSections(in: sut.helpEntries) == dataSource.subtitles().count, "Help Panel VC did not retrieve the Subheadings from the DataSource.")
    }
    
    func testVCObtainsEntriesFromDataSource() {
        // Given
        let dataSource = TestHelperPanelDataSource()
        sut.dataSource = dataSource
        let entriesInSection0 = dataSource.helpSectionEntries()["Test 1"]!.count
        let entriesInSection1 = dataSource.helpSectionEntries()["Test 2"]!.count

        // When
        sut.setupView()
        
        // Then
        XCTAssertTrue(sut.helpEntries.numberOfRows(inSection: 0) == entriesInSection0, "Help Panel VC did not retrieve the entries for Section 0 from the DataSource.")
        XCTAssertTrue(sut.helpEntries.numberOfRows(inSection: 1) == entriesInSection1, "Help Panel VC did not retrieve the entries for Section 1 from the DataSource.")
    }
    
    // MARK: - Test doubles
    class TestHelperPanelDataSource: HelpPanelDataSource {
        func helpPanelTitle() -> String {
            return "Test Title"
        }
        
        func subtitles() -> [String] {
            return ["Test 1", "Test 2"]
        }
        
        func helpSectionEntries() -> [String : [String]] {
            return  [ "Test 1": ["Entry 1", "Entry 2"],
                      "Test 2": ["Entry 1", "Entry 2", "Entry 3"]
                    ]
        }
    }
}
