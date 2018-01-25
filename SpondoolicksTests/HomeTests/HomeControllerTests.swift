//
//  All unit tests for Home View Controller
//
//  Created by Andrew Johnson on 17/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import XCTest
@testable import Spondoolicks

class HomeControllerTests: XCTestCase {
    
    // MARK: - Properties
    var sut: HomeViewController! = nil
    
    // MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        
        // Instantiate the View Controller for all tests
        let storyboard = UIStoryboard(name: Global.Identifier.Storyboard.MAIN, bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: Global.Identifier.ViewController.HOME_VC)
            as! HomeViewController
        let _ = sut.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Unit tests
    func testVIPCycleEstablished() {
        // Given
        
        // When
        let interactor = sut.interactor as! HomeInteractor
        let presenter = interactor.presenter as! HomePresenter
        let vc = presenter.viewController as! HomeViewController
        let router = sut.router as! HomeRouter
        let datastore = router.dataStore
        
        // Then
        XCTAssertNotNil(interactor, "VC did not setup a link to the Interactor.")
        XCTAssertNotNil(presenter, "VC did not setup a link between the Interactor and Presenter.")
        XCTAssertNotNil(vc, "VC did not setup a link between the Presenter and View Controller.")
        XCTAssertNotNil(router, "VC did not setup a link to the Router.")
        XCTAssertNotNil(datastore, "VC did not setup a link between the Router and Interactor.")
        XCTAssertTrue(sut === vc, "VC did not complete the VIP cycle back to itself.")
    }
    
    func testVCHasSpondoolicksLabelConnected() {
        // Given
        
        // When
        let spondoolicks = sut.spondoolicksLabel
        
        // Then
        XCTAssertNotNil(spondoolicks, "Home VC does not have the Spondoolicks label connected.")
    }
    
    func testVCHasIntroductionLabelConnected() {
        // Given
        
        // When
        let introduction = sut.introLabel
        
        // Then
        XCTAssertNotNil(introduction, "Home VC does not have the Introduction label connected.")
    }

    func testVCHasOptionsTableViewConnected() {
        // Given
        
        // When
        let tableView = sut.optionsTable
        
        // Then
        XCTAssertNotNil(tableView, "Home VC does not have a table view connected.")
    }

    func testTableViewHasTwoRows() {
        // Given
        let tableView = sut.optionsTable!
        
        // When
        let rows = tableView.numberOfRows(inSection: 0)
        
        // Then
        XCTAssertEqual(rows, 2, "TableView does not have the right number of rows (\(rows).)")
    }
    
    func testRouteToShowUsers() {
        // given
        let router = HomeRouterSpy()
        sut.router = router
        
        // when
        sut.usersSelected()
        
        // Then
        XCTAssertTrue(router.routeToShowUsersCalled, "VC did not route to Show Users VC when Users selected.")
    }
    
    func testRouteToSettings() {
        // given
        let router = HomeRouterSpy()
        sut.router = router
        
        // when
        sut.settingsSelected()
        
        // Then
        XCTAssertTrue(router.routeToShowSettingsCalled, "VC did not route to Settings VC when Settings selected.")
    }
    
    // MARK: - Test doubles
    class HomeRouterSpy: HomeRouter {
        var routeToShowUsersCalled = false
        var routeToShowSettingsCalled = false
        
        override func routeToShowUsers(segue: UIStoryboardSegue?) {
            routeToShowUsersCalled = true
        }
        
        override func routeToShowSettings(segue: UIStoryboardSegue?) {
            routeToShowSettingsCalled = true
        }
    }
}
