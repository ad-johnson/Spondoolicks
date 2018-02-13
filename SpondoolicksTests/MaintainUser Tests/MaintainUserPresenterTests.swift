//
//  Created by Andrew Johnson on 30/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import XCTest
@testable import Spondoolicks

class MaintainUserPresenterTests: XCTestCase {
    
    // MARK: - Properties
    var sut: MaintainUserPresenter!
    
    //MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        
        sut = MaintainUserPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Unit tests
    func testPresenterCallsVCWithUserBeingMaintained() {
        // Given
        let vc = MaintainUserViewControllerSpy()
        let user = TempUser(userId: 0, userName: "Test", avatarImage: "Test")
        sut.viewController = vc
        
        // When
        sut.presentUser(response: MaintainUser.GetUser.Response(user: user))
        
        // Then
        XCTAssertTrue(vc.displayUserCalled, "Maintain User Presenter did not call View Controller with result of getUser with user to change.")
    }
    
    func testPresenterCallsVCWithNoUserBeingMaintained() {
        // Given
        let vc = MaintainUserViewControllerSpy()
        sut.viewController = vc

        // When
        sut.presentUser(response: MaintainUser.GetUser.Response(user: nil))
        
        // Then
        XCTAssertTrue(vc.displayUserCalled, "Maintain User Presenter did not call View Controller with result of getUser with no user to change.")
    }
    
   func testPresenterCallsVCWithUpdateUserResult() {
    // Given
    let vc = MaintainUserViewControllerSpy()
    sut.viewController = vc

    // When
    sut.presentUpdateUserResult(response: MaintainUser.UpdateUser.Response(error: nil))
    
    // Then
    XCTAssertTrue(vc.userUpdatedCalled, "Maintain User Presenter did not call View Controller with result of updating user.")
    }
    
    // MARK: - Test doubles
    class MaintainUserViewControllerSpy: MaintainUserViewController {
        var displayUserCalled = false
        var userUpdatedCalled = false
        
        override func displayUser(viewModel: MaintainUser.GetUser.ViewModel?) {
            displayUserCalled = true
        }
        override func userUpdated(viewModel: MaintainUser.UpdateUser.ViewModel) {
            userUpdatedCalled = true
        }
    }
}
