//
//  Created by Andrew Johnson on 30/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import XCTest
@testable import Spondoolicks

class MaintainUserInteractorTests: XCTestCase {
    
    // MARK: - Properties
    var sut: MaintainUserInteractor!
    var cdm: CoreDataManagerMock!
    var users: [User]!

    //MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        
        sut = MaintainUserInteractor()
        if cdm == nil {
            cdm = CoreDataManagerMock.initialiseForTest()
        }
        sut.worker.coreDataManager = cdm
        users = cdm.addUsersForTest()
    }
    
    override func tearDown() {
        super.tearDown()
        cdm.deleteUsersForTest()
    }
    
    // MARK: - Unit tests
    func testInteractorCallsWorkerToAddUser() {
        // Given
        let worker = MaintainUserWorkerSpy()
        sut.worker = worker
        
        // When
        sut.addUser(request: MaintainUser.UpdateUser.Request(userName: "Test", avatarImage: "Test"))
        
        // Then
        XCTAssertTrue(worker.addUserCalled, "Maintain User Interactor did not call worker to add user.")
    }
    
    func testInteractorCallsWorkerToChangeUser() {
        // Given
        let worker = MaintainUserWorkerSpy()
        sut.worker = worker
        let user = users[0]
        sut.userBeingMaintained = user
        
        // When
        sut.changeUser(request: MaintainUser.UpdateUser.Request(userName: "Louise", avatarImage: "1"))
        
        // Then
        XCTAssertTrue(worker.changeUserCalled, "Maintain User Interactor did not call worker to change user.")
    }
    
    func testInteractorCallsWorkerWithCorrectDataOnAddUser() {
        // Given
        let worker = MaintainUserWorkerMock()
        sut.worker = worker
        
        // When
        sut.addUser(request: MaintainUser.UpdateUser.Request(userName: "Louise", avatarImage: "1"))
        
        // Then
        XCTAssertTrue(worker.updatePassedValidData(expectedName: "Louise", expectedAvatarImage: "1"), "Maintain User Interactor did not pass valid user data to Worker to Add User.")
    }
    
    func testInteractorCallsWorkerWithCorrectDataOnChangeUser() {
        // Given
        let worker = MaintainUserWorkerMock()
        sut.worker = worker
        let user = users[0]
        sut.userBeingMaintained = user
        
        // When
        sut.changeUser(request: MaintainUser.UpdateUser.Request(userName: "Louise", avatarImage: "1"))
        
        // Then
        XCTAssertTrue(worker.updatePassedValidData(expectedName: "Louise", expectedAvatarImage: "1"), "Maintain User Interactor did not pass valid user data to Worker to Change User.")
    }

    func testInteractorCallsPresenterWithUpdateResultWithNoError() {
        // Given
        let presenter = MaintainUserPresenterSpy()
        sut.presenter = presenter
        
        // When
        sut.userUpdated(true)
        
        // Then
        XCTAssertTrue(presenter.presentUpdateUserResultCalled, "Maintain User Interactor did not call Presenter with result of updating User.")
    }
    
    func testInteractorCallsPresenterWithErrorIfAddingUserWithSameName() {
        // Given
        let presenter = MaintainUserPresenterSpy()
        sut.presenter = presenter
        let worker = MaintainUserWorkerMock()
        sut.worker = worker
        sut.users = users
        
        // When
        sut.addUser(request: MaintainUser.UpdateUser.Request(userName: "Andrew", avatarImage: "1"))
        
        // Then
        XCTAssertTrue(presenter.wasErrorPassed(), "Maintain User Interactor did not call Presenter with an Error when adding an existing user.")
    }
    
    func testInteractorCallsPresenterWithErrorIfChangingUserWithSameName() {
        // Given
        let presenter = MaintainUserPresenterSpy()
        sut.presenter = presenter
        let worker = MaintainUserWorkerMock()
        sut.worker = worker
        let user = users[1]
        sut.userBeingMaintained = user
        sut.users = users

        // When
        sut.changeUser(request: MaintainUser.UpdateUser.Request(userName: "Andrew", avatarImage: "1"))
        
        // Then
        XCTAssertTrue(presenter.wasErrorPassed(), "Maintain User Interactor did not call Presenter with an Error when changing an existing user.")
    }

    // MARK: - Test doubles
    class MaintainUserWorkerSpy: MaintainUserWorker {
        var addUserCalled = false
        var changeUserCalled = false
        
        override func addUser(name: String, avatarImage: String, completion: @escaping (User) -> ()) {
            addUserCalled = true
        }
        
        override func changeUser(_ user: User, completion: @escaping (Bool) -> ()) {
            changeUserCalled = true
        }
    }
    
    class MaintainUserWorkerMock: MaintainUserWorker {
        var name: String!
        var avatarImage: String!
        
        override func addUser(name: String, avatarImage: String, completion: @escaping (User) -> ()) {
            self.name = name
            self.avatarImage = avatarImage
        }
        
        override func changeUser(_ user: User, completion: @escaping (Bool) -> ()) {
            self.name = user.name
            self.avatarImage = user.avatarImage
        }
        
        func updatePassedValidData(expectedName: String, expectedAvatarImage: String) -> Bool {
            return  self.name == expectedName &&
                    self.avatarImage == expectedAvatarImage
        }
    }
    
    class MaintainUserPresenterSpy: MaintainUserPresenter {
        var presentUpdateUserResultCalled = false
        var error: Error?
        
        override func presentUpdateUserResult(response: MaintainUser.UpdateUser.Response) {
            presentUpdateUserResultCalled = true
            error = response.error
        }
        
        func wasErrorPassed() -> Bool {
            return error != nil
        }
    }
}
