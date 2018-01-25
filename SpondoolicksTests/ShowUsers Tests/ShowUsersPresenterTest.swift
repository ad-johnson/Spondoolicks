//
//  ShowUsersPresenterTest.swift
//  SpondoolicksTests
//
//  Created by Andrew Johnson on 25/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import XCTest
@testable import Spondoolicks

class ShowUsersPresenterTest: XCTestCase {
    
    // MARK: - Properties
    var sut: ShowUsersPresenter!
    
    //MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        
        sut = ShowUsersPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testPresenterCallsVCWithFindUsersResults() {
        // Given
        let vc = ShowUsersViewControllerSpy()
        sut.viewController = vc
        var users: [TempUser] = []
        users.append(TempUser(userName: "Test", avatarImage: "0"))
        
        // When
        sut.presentFoundUsers(response: ShowUsers.FindUsers.Response(users: users))
        
        // Then
        XCTAssertTrue(vc.displayUsersCalled, "Show Users Presenter did not call VC with results of Find User.")
    }
    
    // MARK: - Test doubles
    class ShowUsersViewControllerSpy: ShowUsersViewController {
        var displayUsersCalled = false
        
        override func displayUsers(viewModel: ShowUsers.FindUsers.ViewModel) {
            displayUsersCalled = true
        }
    }
}
