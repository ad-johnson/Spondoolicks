//
//  MaintainUserViewController.swift
//
//  Created by Andrew Johnson on 27/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol MaintainUserDisplayLogic: class {
    func displayUser(viewModel: MaintainUser.GetUser.ViewModel?)
    func userUpdated(viewModel: MaintainUser.UpdateUser.ViewModel)
}

class MaintainUserViewController: UIViewController, UITextFieldDelegate, MaintainUserDisplayLogic {
    // MARK: - Properties
    var interactor: MaintainUserBusinessLogic?
    var router: (NSObjectProtocol & MaintainUserRoutingLogic & MaintainUserDataPassing)?
    var isAddingUser = true
    var selectedAvatar: String?
    var tap: UITapGestureRecognizer!

    // MARK: - IBOutlets
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var helpButton: UIBarButtonItem!
    @IBOutlet weak var userName: spBorderedTextField!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var avatarCollection: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = MaintainUserInteractor()
        let presenter = MaintainUserPresenter()
        let router = MaintainUserRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - View handling
    func setupView() {
        userName.delegate = self
        avatarCollection.delegate = self
        avatarCollection.dataSource = self
        
        // Setup cells for automatic sizing to support image re-sizing set by
        // the user.
        flowLayout.estimatedItemSize = CGSize(width: 56, height: 56)
        flowLayout.itemSize = UICollectionViewFlowLayoutAutomaticSize
 
        if let colour = UIColor(named: "sp Grey") {
            userName.attributedPlaceholder = NSAttributedString(string: "My name is", attributes: [NSAttributedStringKey.foregroundColor: colour.withAlphaComponent(0.5) ])
        } else {
            userName.attributedPlaceholder = NSAttributedString(string: "My name is", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.5) ])
        }
        
        tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.isEnabled = false
        view.addGestureRecognizer(tap)

        getUser()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Only enable the tap to hide keyboard when editing user name
        // otherwise it will not be possible to select an avatar
        tap.isEnabled = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Only enable the tap to hide keyboard when editing user name
        // otherwise it will not be possible to select an avatar
        tap.isEnabled = false
        handleSaveButtonState()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func handleSaveButtonState() {
        if let userName = userName.text, let _ = selectedAvatar, !userName.isEmpty {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        flowLayout.invalidateLayout()
    }
    
    func displayError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }


    // MARK: - IBActions
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        updateUser()
    }
    
    @IBAction func helpTapped(_ sender: UIBarButtonItem) {
        showHelpPanel()
    }
    
    // MARK: - Use cases
    func getUser() {
        let request = MaintainUser.GetUser.Request()
        interactor?.getUser(request: request)
    }
    
    func updateUser() {
        if let userName = userName.text, let avatarImage = selectedAvatar {
            let request = MaintainUser.UpdateUser.Request(userName: userName, avatarImage: avatarImage)
            if isAddingUser {
                interactor?.addUser(request: request)
            } else {
                interactor?.changeUser(request: request)
            }
        }
    }
    
    // MARK: - Use case responses
    func displayUser(viewModel: MaintainUser.GetUser.ViewModel?) {
        if let user = viewModel?.displayedUser {
            isAddingUser = false
            self.navigationItem.title = "Change User"
            userName.text = user.userName
            selectedAvatar = user.avatarImage
            if let image = UIImage(named: user.avatarImage) {
                userAvatar.image = image
            } else {
                userAvatar.image = UIImage(named: Global.AssetInfo.PROFILE_ICON)
            }
        } else {
            self.navigationItem.title = "Add User"
            userName.text = ""
            userAvatar.image = UIImage(named: Global.AssetInfo.PROFILE_ICON)
        }
    }
    
    func userUpdated(viewModel: MaintainUser.UpdateUser.ViewModel) {
        if let _ = viewModel.error {
            let action = isAddingUser ? "add" : "change"
            displayError("Could not \(action) the user details.  Something went wrong.")
        } else {
            router?.routeToShowUsers(segue: nil)
        }
    }
}

extension MaintainUserViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageName = Global.AssetInfo.getAvatarName(indexPath: indexPath)
        if let image = UIImage(named: imageName) {
            selectedAvatar = imageName
            userAvatar.image = image
        }
        handleSaveButtonState()
    }
    
}

extension MaintainUserViewController: UICollectionViewDataSource {
    // Use sections to hold girl/boy Avatar images seperately
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Global.Identifier.Cell.AVATAR_HEADER, for: indexPath) as! AvatarHeaderView
            headerView.configureHeader(section: indexPath.section)
            return headerView
        default:
        fatalError("Maintain User CollectionView header at section \(indexPath.section) is not an Header Kind: \(kind)")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Global.AssetInfo.NUMBER_OF_AVATARS[section]
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Global.Identifier.Cell.AVATAR_CELL, for: indexPath) as? AvatarCell {
            cell.configureCell(indexPath: indexPath)
            return cell
        } else {
            fatalError("Maintain User CollectionView cell at row \(indexPath.row) is not an \(Global.Identifier.Cell.AVATAR_CELL)")
        }
    }
}

extension MaintainUserViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        // Use a dummy label to calculate the height.  It isn't fixed because of
        // Dynamic Type and there is no 'automatic dynamic heading sizing' as there
        // is for cells.
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 1
        if let font = UIFont(name: Global.FontInfo.BODY_FONT, size: 20) {
            label.font = UIFontMetrics.default.scaledFont(for: font)
        }

        label.text = Global.Identifier.Names.AVATAR_HEADING_NAMES[section]
        label.sizeToFit()
        
        // Set some extra pixels to account for an 8 pixel spacing at the top and bottom
        // as constraints are set on the Storyboard.
        return CGSize(width: collectionView.frame.width, height: label.frame.height + 16)
    }

}

extension MaintainUserViewController: HelpPanelDataSource, HelpPanelLauncherHelper {
    enum Subtitle: String {
        case Overview
        case AddUser = "Add User"
        case ChangeUser = "Change User"
        case Avatars
        case Buttons
    }
    
    func helpPanelTitle() -> String {
        return isAddingUser ? Subtitle.AddUser.rawValue : Subtitle.ChangeUser.rawValue
    }
    
    func subtitles() -> [String] {
        let option = isAddingUser ? Subtitle.AddUser.rawValue : Subtitle.ChangeUser.rawValue
        return [Subtitle.Overview.rawValue,
                option,
                Subtitle.Avatars.rawValue,
                Subtitle.Buttons.rawValue]
    }
    
    func helpSectionEntries() -> [String : [String]] {
        var option: String!
        var entry: [String]!
        
        if isAddingUser {
            option = Subtitle.AddUser.rawValue
            entry = ["This will let you add a new user with their own accounts.",
            "You will need to provide a name and an image to represent them.",
            "Press the save button to add the user."]
        } else {
            option = Subtitle.ChangeUser.rawValue
            entry = ["This will allow you to change the name or image of an existing user.",
            "Enter a new name and select a new image to represent them.",
            "You don't have to change both items if you don't want to.",
            "Press save to change the user details."]
        }
        
        return [
            Subtitle.Overview.rawValue :    ["This screen will allow you to add or change the user.",
            "You can tell what you are doing by looking at the title.",
            "If you change your mind, you can just press the Users button at the top without pressing the save button.  Any changes you have made and not saved will be forgotten."
            ],
            option : entry,
            Subtitle.Avatars.rawValue :     ["Each user can have a picture to represent them in the app.",
            "You can have the same picture as someone else if you want.",
            "Just select the one you want and you will see it in the slot at the top of the screen above your name."
            ],
            Subtitle.Buttons.rawValue :     ["Save - Press save to remember any name or image changes you have made.  The save button only works when you have made a change and you have a name and an image.",
            "Users - Press users to return back to the list of users.  If you haven't saved any changes then they will be forgotten."
            ]
        ]
    }
}
