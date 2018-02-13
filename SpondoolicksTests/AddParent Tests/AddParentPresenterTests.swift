//
//  Created by Andrew Johnson on 12/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import XCTest
@testable import Spondoolicks

class AddParentPresenterTests: XCTestCase {
    
    // MARK: - Properties
    var sut: AddParentPresenter!
    
    //MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        
        sut = AddParentPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Unit tests
    func testPresenterCallsVCWithResultOfAddParent() {
        // Given
        let vc = AddParentViewControllerSpy()
        sut.viewController = vc
        
        // When
        sut.presentAddParentResult(response: AddParent.AddParent.Response(parent: Parent()))
        
        // Then
        XCTAssertTrue(vc.displayAddParentResultCalled, "AddParent Presenter did not call VC with result of add parent.")
    }
    
    class AddParentViewControllerSpy: AddParentViewController {
        var displayAddParentResultCalled = false
        
        override func displayAddParentResult(viewModel: AddParent.AddParent.ViewModel) {
            displayAddParentResultCalled = true
        }
    }
    
}
