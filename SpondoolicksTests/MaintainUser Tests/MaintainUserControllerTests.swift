//
//  MaintainUserControllerTests.swift
//  SpondoolicksTests
//
//  Created by Andrew Johnson on 30/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import XCTest
import UIKit

@testable import Spondoolicks

class MaintainUserControllerTests: XCTestCase {
    
    // MARK: - Properties
    var sut: MaintainUserViewController! = nil
    
    // MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        
        // Instantiate the View Controller for all tests
        let storyboard = UIStoryboard(name: Global.Identifier.Storyboard.MAIN, bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: Global.Identifier.ViewController.MAINTAIN_USER_VC)
            as! MaintainUserViewController
        let _ = sut.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Unit tests
    func testVIPCycleEstablished() {
        // Given
        
        // When
        let interactor = sut.interactor as! MaintainUserInteractor
        let presenter = interactor.presenter as! MaintainUserPresenter
        let vc = presenter.viewController as! MaintainUserViewController
        let router = sut.router as! MaintainUserRouter
        let datastore = router.dataStore
        
        // Then
        XCTAssertNotNil(interactor, "VC did not setup a link to the Interactor.")
        XCTAssertNotNil(presenter, "VC did not setup a link between the Interactor and Presenter.")
        XCTAssertNotNil(vc, "VC did not setup a link between the Presenter and View Controller.")
        XCTAssertNotNil(router, "VC did not setup a link to the Router.")
        XCTAssertNotNil(datastore, "VC did not setup a link between the Router and Interactor.")
        XCTAssertTrue(sut === vc, "VC did not complete the VIP cycle back to itself.")
    }

    func testVCHasSaveButtonConnected() {
        // Given

        // When
        
        // Then
        XCTAssertNotNil(sut.saveButton, "MaintainUser VC does not have a connected save button.")
    }
    
    func testSaveButtonHasTheCorrectAction() {
        // Given
        let saveButton = sut.saveButton!
        
        // Then
        if let action = saveButton.action {
            XCTAssertTrue(action.description == "saveTapped:",
                          "The MaintainUser VC Save button is not connected to the right action")
        } else {
            XCTFail("The MaintainUser VC Save button has no actions connected")
        }
    }

    func testVCHasHelpButtonConnected() {
        // Given

        // When

        // Then
        XCTAssertNotNil(sut.helpButton, "MaintainUser VC does not have a connected help button.")
    }
    
    func testHelpButtonHasTheCorrectAction() {
        // Given
        let button = sut.helpButton!
        
        // When
        
        // Then
        if let action = button.action {
            XCTAssertTrue(action.description == "helpTapped:",
                          "The MaintainUser VC Help button is not connected to the right action")
        } else {
            XCTFail("The MaintainUser VC Help button has no actions connected")
        }
    }

    func testVCHasUserNameConnected() {
        // Given
        
        // When
        
        // Then
        XCTAssertNotNil(sut.userName, "MaintainUser VC does not have a connected User Name Textfield.")
    }
    
    func testVCHasAvatarImageConnected() {
        // Given
        
        // When
        
        // Then
        XCTAssertNotNil(sut.userAvatar, "MaintainUser VC does not have a connected User Avatar ImageView.")
    }
    
    func testVCHasCollectionViewConnected() {
        // Given
        
        // When
        
        // Then
        XCTAssertNotNil(sut.avatarCollection, "MaintainUser VC does not have a connected Collection View.")
    }

    func testVCHasFlowLayoutConnected() {
        // Given
        
        // When
        
        // Then
        XCTAssertNotNil(sut.flowLayout, "MaintainUser VC does not have a connected Flow Layout.")
    }
    
    
    func testVCCallsInteractorToGetUser() {
        // Given
        let interactor = MaintainUserInteractorSpy()
        sut.interactor = interactor
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(interactor.getUserCalled, "Maintain User VC did not call getUser on interactor.")
    }
    
    func testCollectionViewHasTwoSections() {
        // Given
        let collectionView = sut.avatarCollection!
        
        // When
        
        // Then
        XCTAssertTrue(collectionView.numberOfSections == 2, "Maintain User Collection View is not creating two sections: \(collectionView.numberOfSections).")
    }
    
    func testCollectionViewSectionZeroHasCorrectNumberOfImages() {
        // Given
        let collectionView = sut.avatarCollection!
        let numberOfImages = collectionView.numberOfItems(inSection: 0)
        
        // When
        
        // Then
        XCTAssertTrue(numberOfImages == Global.AssetInfo.NUMBER_OF_AVATARS[0], "Maintain User Collection View is not loading the right number of images in Section 0.")
    }
    
    func testCollectionViewSectionOneHasCorrectNumberOfImages() {
        // Given
        let collectionView = sut.avatarCollection!
        let numberOfImages = collectionView.numberOfItems(inSection: 1)
        
        // When
        
        // Then
        XCTAssertTrue(numberOfImages == Global.AssetInfo.NUMBER_OF_AVATARS[1], "Maintain User Collection View is not loading the right number of images in Section 0.")
    }
    
    func testSaveButtonDisabledWhenFirstDisplayed() {
        // Given
        
        // When
        
        // Then
        XCTAssertFalse(sut.saveButton.isEnabled, "Save Button is enabled when Maintain User view first loaded.")
    }
    
    func testTitleIsAddWhenNoUserFound() {
        // Given
        let title = sut.navigationItem.title
        
        // When
        
        // Then
        XCTAssertTrue(title == "Add User", "Maintain User VC did not set title to Add User when no user being changed.")
    }
    
    func testUserNameIsBlankWhenNoUserFound() {
        // Given
        let userName = sut.userName.text
        
        // When
        
        // Then
        XCTAssertTrue(userName == "", "Maintain User VC set the user name to a value when no user is being changed.")
    }
    
    func testAvatarNameIsNilWhenNoUserFound() {
        // Given
        let avatarName = sut.selectedAvatar
        
        // When
        
        // Then
        XCTAssertNil(avatarName, "Maintain User VC set an avatar name when no user is being changed.")
    }
    
    func testTitleIsChangeWhenUserFound() {
        // Given
        setUserOnInteractor()

        // When
        sut.viewDidLoad()
        let title = sut.navigationItem.title

        // Then
        XCTAssertTrue(title == "Change User", "Maintain User VC did not set title to Change User when a user is being changed.")
    }
    
    func testUserNameFieldIsUpdatedWithUserNameWhenUserIsFound() {
        // Given
        setUserOnInteractor()
        
        // When
        sut.viewDidLoad()
        let userName = sut.userName.text!
        
        // Then
        XCTAssertTrue(userName == "Test", "Maintain User VC did not set user name value when a user is being changed.")
    }
    
    func testAvatarNameIsNotNilWhenUserFound() {
        // Given
        setUserOnInteractor()
        
        // When
        sut.viewDidLoad()
        let avatarName = sut.selectedAvatar
        
        // Then
        XCTAssertNotNil(avatarName, "Maintain User VC did not set Avatar Name when a user is being changed.")
    }
    
    func testSaveButtonEnabledWhenAvatarSelectedWhenChangingUser() {
        // Given
        setUserOnInteractor()
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        sut.viewDidLoad()
        sut.collectionView(sut.avatarCollection, didSelectItemAt: indexPath)
        
        // Then
        XCTAssertTrue(sut.saveButton.isEnabled, "Maintain User VC did not enable the save button when avatar image selected and name field completed.")
    }
    
    func testSaveButtonEnabledWhenNameNotBlankAndAvatarSelected() {
        // Given
        sut.userName.text = "Test"
        sut.selectedAvatar = "Test"
        sut.saveButton.isEnabled = false
        
        // When
        sut.textFieldDidEndEditing(sut.userName)
        
        // Then
        XCTAssertTrue(sut.saveButton.isEnabled, "Maintain User VC did not enable the save button when user name and avatar image set.")
    }
    
    func testVCCallsInteractorToAddUser() {
        // Given
        let interactor = setupUserUpdateSpyTest(adding: true)

        // When
        sut.saveTapped(UIBarButtonItem())
        
        // Then
        XCTAssertTrue(interactor.addUserCalled, "Maintain User VC did not call interactor to Add a user.")
    }
    
    func testVCCallsInteractorToChangeUser() {
        // Given
        let interactor = setupUserUpdateSpyTest(adding: false)

        // When
        sut.saveTapped(UIBarButtonItem())

        // Then
        XCTAssertTrue(interactor.changeUserCalled, "Maintain User VC did not call interactor to Change a user.")

    }
    
    func testAddUserPassesUserDetailsToInteractorWhenAdding() {
        // Given
        let interactor = setupUserUpdateMockTest(adding: true)

        // When
        sut.saveTapped(UIBarButtonItem())

        // Then
        XCTAssertTrue(interactor.updateWasValid(), "Maintain Interactor VC did not pass the right user data to the Interactor when Adding user.")
    }
    
    func testChangeUserSavesUserDetails() {
        // Given
        let interactor = setupUserUpdateMockTest(adding: false)

        // When
        sut.saveTapped(UIBarButtonItem())

        // Then
        XCTAssertTrue(interactor.updateWasValid(), "Maintain Interactor VC did not pass the right user data to the Interactor when Changing a user.")
    }
    
    func testVCHandlesUpdateError() {
        // Given
        let sutFake = MaintainUserViewControllerSpy()
        
        // When
        // userUpdated is inherited and thus the 'real' code is executed
        sutFake.userUpdated(viewModel: MaintainUser.UpdateUser.ViewModel(error: NSError(domain: "Domain", code: 0, userInfo: nil)))
        
        // Then
        XCTAssertTrue(sutFake.displayErrorCalled, "Maintain User VC did not display the Update User error.")
    }
    
    // MARK: - Integration tests
    func testUserIsAddedWithNoError() {
        // Given
        let users = TempUser.users
        let interceptor = MaintainUserViewControllerInterceptor()
        let (_, expectation) = setupIntegrationTest(adding: true, interceptor: interceptor)

        // When
        sut.saveTapped(UIBarButtonItem())
        let _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        let lastUser = TempUser.users.last!
        
        // Then
        XCTAssertTrue(users.count == TempUser.users.count - 1, "Maintain User did not Add a new user.")
        XCTAssertTrue(lastUser.userName == "NewUser", "Maintain User did not Add a new user with the correct User Name.")
        XCTAssertTrue(lastUser.avatarImage == "boy-10", "Maintain User did not Add a new user with the correct Avatar Image.")
    }
    
    func testUserIsChangedWithNoError() {
        // Given
        let users = TempUser.users
        let interceptor = MaintainUserViewControllerInterceptor()
        let (interactor, expectation) = setupIntegrationTest(adding: false, interceptor: interceptor)
        interactor.userBeingMaintained = users[0]
        
        // When
        sut.saveTapped(UIBarButtonItem())
        let _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        let updatedUser = TempUser.users[0]
        
        // Then
        XCTAssertTrue(users.count == TempUser.users.count, "Maintain User Added a new user instead of changing one.")
        XCTAssertTrue(updatedUser.userName == "NewUser", "Maintain User did not change the name of the user.")
        XCTAssertTrue(updatedUser.avatarImage == "boy-10", "Maintain User did not change the Avatar Image of the user.")
    }
    
    func testUserIsNotChangedIfError() {
        // Given
        let users = TempUser.users
        let interceptor = MaintainUserViewControllerInterceptor()
        let (interactor, expectation) = setupIntegrationTest(adding: false, interceptor: interceptor)
        interactor.userBeingMaintained = TempUser(userId: 10, userName: "Test", avatarImage: "Test")
        
        // When
        sut.saveTapped(UIBarButtonItem())
        let _ = XCTWaiter.wait(for: [expectation], timeout: 5)
        
        // Then
        XCTAssertTrue(interceptor.errorReceived, "Maintain User did not return an error when invalid user was changed.")
        XCTAssertTrue(users == TempUser.users, "Maintain User changed a user when it had no valid user to change.")
    }
    
    // Mark: - Helper methods
    func setUserOnInteractor() {
        let interactor = sut.interactor
        (interactor as! MaintainUserInteractor).userBeingMaintained = TempUser(userId: 0, userName: "Test", avatarImage: "Test")
    }
    
    func setupUserUpdateSpyTest(adding: Bool) -> MaintainUserInteractorSpy {
        let interactor = MaintainUserInteractorSpy()
        setupUserUpdate(adding: adding, interactor: interactor)
        return interactor
    }
    
    func setupUserUpdateMockTest(adding: Bool) -> MaintainUserInteractorMock {
        let interactor = MaintainUserInteractorMock()
        setupUserUpdate(adding: adding, interactor: interactor)
        return interactor
    }
    
    func setupUserUpdate(adding: Bool, interactor: MaintainUserInteractor) {
        sut.interactor = interactor
        sut.isAddingUser = adding
        sut.userName.text = "Test"
        sut.selectedAvatar = "Test"
    }
    
    func setupIntegrationTest(adding: Bool, interceptor: MaintainUserViewControllerInterceptor) -> (MaintainUserInteractor, XCTestExpectation) {
        sut.userName.text = "NewUser"
        sut.selectedAvatar = "boy-10"
        sut.isAddingUser = adding
        let expectation = XCTestExpectation(description: "Wait for callbacks")
        interceptor.expectation = expectation
        interceptor.realVC = sut
        let interactor = sut.interactor as! MaintainUserInteractor
        (interactor.presenter as! MaintainUserPresenter).viewController = interceptor
        let router = MaintainUserRouterFake()
        sut.router = router
        return (interactor, expectation)
    }
    
    // MARK: - Test doubles
    class MaintainUserInteractorSpy: MaintainUserInteractor {
        var getUserCalled = false
        var addUserCalled = false
        var changeUserCalled = false
        
        override func getUser(request: MaintainUser.GetUser.Request) {
            getUserCalled = true
        }
        override func addUser(request: MaintainUser.UpdateUser.Request) {
            addUserCalled = true
        }
        override func changeUser(request: MaintainUser.UpdateUser.Request) {
            changeUserCalled = true
        }
    }
    
    class MaintainUserInteractorMock: MaintainUserInteractor {
        var userName: String?
        var avatarImage: String?
        
        override func addUser(request: MaintainUser.UpdateUser.Request) {
            userName = request.userName
            avatarImage = request.avatarImage
        }

        override func changeUser(request: MaintainUser.UpdateUser.Request) {
            userName = request.userName
            avatarImage = request.avatarImage
        }
        
        func updateWasValid() -> Bool {
            return userName != nil && avatarImage != nil
        }
    }
    
    
    class MaintainUserViewControllerSpy: MaintainUserViewController {
        var displayErrorCalled = false
        
        override func displayError(_ message: String) {
            displayErrorCalled = true
        }
    }

    class MaintainUserViewControllerInterceptor: MaintainUserViewController {
        var realVC: MaintainUserViewController!
        var expectation: XCTestExpectation!
        var errorReceived = false
        
        override func userUpdated(viewModel: MaintainUser.UpdateUser.ViewModel) {
            realVC.userUpdated(viewModel: viewModel)
            errorReceived = viewModel.error != nil
            expectation.fulfill()
        }
    }
    
    class MaintainUserRouterFake: MaintainUserRouter {
        override func routeToShowUsers(segue: UIStoryboardSegue?) {
            // Do nothing.
        }
    }
}
