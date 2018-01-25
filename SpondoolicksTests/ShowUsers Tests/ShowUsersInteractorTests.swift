//
//  Tests functionality of the Show Users Interactor
//
//  Created by Andrew Johnson on 24/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import XCTest
@testable import Spondoolicks

class ShowUsersInteractorTests: XCTestCase {
    
    // MARK: - Properties
    var sut: ShowUsersInteractor!
    
    //MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        
        sut = ShowUsersInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCallsWorkerToFindUsers() {
        // Given
        let worker = ShowUsersWorkerSpy()
        sut.worker = worker
        
        // When
        sut.findUsers(request: ShowUsers.FindUsers.Request())
        
        // Then
        XCTAssertTrue(worker.findUsersCalled, "Show Users Interactor did not call the Worker to Find Users.")
    }
    
    func testCallsPresenterWithFindUserResults() {
        // Given
        let presenter = ShowUsersPresenterSpy()
        sut.presenter = presenter
        
        // When
        sut.usersFound(users: [])
        
        // Then
        XCTAssertTrue(presenter.presentFoundUsersCalled, "Show Users Interactor did not call Presenter with Find User results.")
    }
    
    // MARK: - Test doubles
    class ShowUsersWorkerSpy: ShowUsersWorker {
        var findUsersCalled = false
        
        override func findUsers(users: @escaping ShowUsersWorker.userCallback) {
            findUsersCalled = true
        }
    }
    
    class ShowUsersPresenterSpy: ShowUsersPresenter {
        var presentFoundUsersCalled = false
        
        override func presentFoundUsers(response: ShowUsers.FindUsers.Response) {
            presentFoundUsersCalled = true
        }
    }
}
