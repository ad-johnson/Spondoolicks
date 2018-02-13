//
//  Created by Andrew Johnson on 30/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import XCTest
@testable import Spondoolicks

class MaintainUserInteractorTests: XCTestCase {
    
    // MARK: - Properties
    var sut: MaintainUserInteractor!
    
    //MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        
        sut = MaintainUserInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
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
        let user = TempUser(userId: TempUser.users.count, userName: "Test", avatarImage: "Test")
        sut.userBeingMaintained = user
        
        // When
        sut.changeUser(request: MaintainUser.UpdateUser.Request(userName: "Test", avatarImage: "Test"))
        
        // Then
        XCTAssertTrue(worker.changeUserCalled, "Maintain User Interactor did not call worker to change user.")
    }
    
    func testInteractorCallsWorkerWithCorrectDataOnAddUser() {
        // Given
        let worker = MaintainUserWorkerMock()
        sut.worker = worker
        let user = TempUser(userId: TempUser.users.count, userName: "Test", avatarImage: "Test")
        
        // When
        sut.addUser(request: MaintainUser.UpdateUser.Request(userName: user.userName, avatarImage: user.avatarImage))
        
        // Then
        XCTAssertTrue(worker.updatePassedValidData(user: user), "Maintain User Interactor did not pass valid user data to Worker to Add User.")
    }
    
    func testInteractorCallsWorkerWithCorrectDataOnChangeUser() {
        // Given
        let worker = MaintainUserWorkerMock()
        sut.worker = worker
        let user = TempUser(userId: 1, userName: "Test", avatarImage: "Test")
        sut.userBeingMaintained = user
        
        // When
        sut.changeUser(request: MaintainUser.UpdateUser.Request(userName: user.userName, avatarImage: user.avatarImage))
        
        // Then
        XCTAssertTrue(worker.updatePassedValidData(user: user), "Maintain User Interactor did not pass valid user data to Worker to Add User.")
    }

    func testInteractorCallsPresenterWithUpdateResultWithNoError() {
        // Given
        let presenter = MaintainUserPresenterSpy()
        sut.presenter = presenter
        
        // When
        sut.userUpdated(error: nil)
        
        // Then
        XCTAssertTrue(presenter.presentUpdateUserResultCalled, "Maintain User Interactor did not call Presenter with result of updating User.")
    }
    func testInteractorCallsPresenterWithUpdateResultWithError() {
        // Given
        let presenter = MaintainUserPresenterSpy()
        sut.presenter = presenter
        
        // When
        sut.userUpdated(error: Global.Errors.UserMaintenanceError.userNotFound)
        
        // Then
        XCTAssertTrue(presenter.presentUpdateUserResultCalled, "Maintain User Interactor did not call Presenter with result of updating User.")
    }

    // MARK: - Test doubles
    class MaintainUserWorkerSpy: MaintainUserWorker {
        var addUserCalled = false
        var changeUserCalled = false
        
        override func addUser(user: TempUser, callback: @escaping MaintainUserWorker.MaintainUserCallback) {
            addUserCalled = true
        }
        
        override func changeUser(user: TempUser, callback: @escaping MaintainUserWorker.MaintainUserCallback) {
            changeUserCalled = true
        }
    }
    
    class MaintainUserWorkerMock: MaintainUserWorker {
        var userId: Int?
        var userName: String!
        var avatarImage: String!
        
        override func addUser(user: TempUser, callback: @escaping MaintainUserWorker.MaintainUserCallback) {
            userId = user.userId
            userName = user.userName
            avatarImage = user.avatarImage
        }
        
        override func changeUser(user: TempUser, callback: @escaping MaintainUserWorker.MaintainUserCallback) {
            userId = user.userId
            userName = user.userName
            avatarImage = user.avatarImage
        }
        
        func updatePassedValidData(user: TempUser) -> Bool {
            return  userId == user.userId &&
                    userName == user.userName &&
                    avatarImage == user.avatarImage
        }
    }
    
    class MaintainUserPresenterSpy: MaintainUserPresenter {
        var presentUpdateUserResultCalled = false
        
        override func presentUpdateUserResult(response: MaintainUser.UpdateUser.Response) {
            presentUpdateUserResultCalled = true
        }
    }
}
