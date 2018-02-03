//
//  Shows all current users registered with the app and allows new users to be
//  created.
//
//  Created by Andrew Johnson on 23/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol ShowUsersDisplayLogic: class {
    func displayUsers(viewModel: ShowUsers.FindUsers.ViewModel)
    func userDeleted(viewModel: ShowUsers.DeleteUser.ViewModel)
}

class ShowUsersViewController: UIViewController, ShowUsersDisplayLogic {
    // MARK: - Properties
    var interactor: ShowUsersBusinessLogic?
    var router: (NSObjectProtocol & ShowUsersRoutingLogic & ShowUsersDataPassing)?
    var displayedUsers: [ShowUsers.FindUsers.ViewModel.DisplayedUser] = []
    var userBeingActioned: IndexPath?
    typealias Handler = (Bool) -> ()
    var deletionSuccess: Handler?
    
    // MARK: - IBOutlets
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var helpButton: UIBarButtonItem!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var userTable: UITableView!
    
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
        let interactor = ShowUsersInteractor()
        let presenter = ShowUsersPresenter()
        let router = ShowUsersRouter()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        findUsers()
    }
    
    // MARK: - View handling
    func setupView() {
        userTable.delegate = self
        userTable.dataSource = self
        
        if let font = UIFont(name: Global.FontInfo.HEADING_FONT, size: 20) {
            introLabel.font = UIFontMetrics.default.scaledFont(for: font)
        }
    }

    func confirmDelete() {
        if let userBeingDeleted = userBeingActioned, let cellBeingDeleted = userTable.cellForRow(at: userBeingDeleted) {
            let userName = displayedUsers[userBeingDeleted.row].userName
            
            let alert = UIAlertController(title: "Delete User", message: "Are you sure you want to permanently delete \(userName)?  There is no going back!", preferredStyle: .actionSheet)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: deleteUser)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) in
                    self.userBeingActioned = nil
                    if let deletionSuccess = self.deletionSuccess {
                        deletionSuccess(false)  // Remove row actions
                    }
            })
            
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            
            // Support display in iPad
            let popover = alert.popoverPresentationController
            popover?.sourceView = cellBeingDeleted
            popover?.sourceRect = cellBeingDeleted.bounds
            popover?.permittedArrowDirections = UIPopoverArrowDirection.any
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    func displayError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - IBActions
    @IBAction func addUserTapped(_ sender: UIBarButtonItem) {
        addUser()
    }
    
    @IBAction func helpTapped(_ sender: UIBarButtonItem) {
        showHelpPanel()
    }

    // MARK: - Use cases: requests
    
    func findUsers() {
        let request = ShowUsers.FindUsers.Request()
        interactor?.findUsers(request: request)
    }
    
    func deleteUser(alertAction: UIAlertAction?) {
        if let userBeingActioned = userBeingActioned {
            let userId = displayedUsers[userBeingActioned.row].userId
            interactor?.deleteUser(request: ShowUsers.DeleteUser.Request(userId: userId))
        }
    }
    
    func addUser() {
        performSegue(withIdentifier: Global.Segue.MAINTAIN_USER, sender: self)
    }
    
    func editUser() {
        performSegue(withIdentifier: Global.Segue.MAINTAIN_USER, sender: self)
    }
    
    // MARK: - Use cases: responses
    func displayUsers(viewModel: ShowUsers.FindUsers.ViewModel) {
        displayedUsers = viewModel.displayedUsers
        userTable.reloadData()
    }
    
    func userDeleted(viewModel: ShowUsers.DeleteUser.ViewModel) {
        if let indexPath = userBeingActioned {
            if let _ = viewModel.error {
                if let deletionSuccess = deletionSuccess {
                    deletionSuccess(false) // Remove row actions
                }
                let name = displayedUsers[indexPath.row].userName
                displayError("Could not delete user \(name).  Something went wrong.")
            } else {
                if let deletionSuccess = deletionSuccess {
                    deletionSuccess(true) // Remove row actions
                }
                userTable.beginUpdates()
                displayedUsers.remove(at: indexPath.row)
                userTable.deleteRows(at: [indexPath], with: .automatic)
                userBeingActioned = nil
                userTable.endUpdates()
            }
        }
    }
}

extension ShowUsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // do something here
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Change", handler: { (action, view, handler) in
            self.userBeingActioned = indexPath
            handler(true)
            self.editUser()
        })
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: { (action, view, handler) in
            self.userBeingActioned = indexPath
            self.deletionSuccess = handler  // store this so we can remove row actions
            self.confirmDelete()
        })
        
        editAction.backgroundColor = UIColor(named: "sp Purple")
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}

extension ShowUsersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Global.Identifier.Cell.USER_CELL, for: indexPath) as? UserCell {
            cell.configureCell(user: displayedUsers[indexPath.row])
            return cell
        } else {
            fatalError("Show Users TableView cell at row \(indexPath.row) is not an \(Global.Identifier.Cell.USER_CELL)")
        }
    }
}


extension ShowUsersViewController: HelpPanelDataSource {
    enum Subtitle: String {
        case Overview
        case AddUser = "Add User"
        case ChangeUser = "Change User"
        case DeleteUser = "Delete User"
        case Buttons
    }
    
    func helpPanelTitle() -> String {
        return "Show Users"
    }
    
    func subtitles() -> [String] {
        return [Subtitle.Overview.rawValue,
                Subtitle.AddUser.rawValue,
                Subtitle.ChangeUser.rawValue,
                Subtitle.DeleteUser.rawValue,
                Subtitle.Buttons.rawValue]
    }
    
    func helpSectionEntries() -> [String : [String]] {
        
        return [
            Subtitle.Overview.rawValue :    ["This screen shows you all the users who can use the app.",
                                             "From here you can select a user, change their details, add a new user, or delete a user."
                                            ],
            Subtitle.AddUser.rawValue :     ["To add a new user, tap on the + button at the top."
                                            ],
            Subtitle.ChangeUser.rawValue :  ["To change a user, swipe to the left on the user name and tap on the Change button that appears."
                                            ],
            Subtitle.DeleteUser.rawValue :  ["To delete a user, swipe to the left on the user name and tap on the Delete button that appears.",
                                             "A new panel will appear to ask you to confirm the delete.",
                                             "WARNING: if you confirm the delete, all that user's data will be removed and cannot be recovered."
                                            ],
            Subtitle.Buttons.rawValue :     ["+ - Press the + button to Add a new User.",
                                             "Home - Press Home to go back to the App start screen, from where you can access the App Settings.",
                                             "Change - Press Change to change the User's details.  This button will appear if you swipe left on a user.",
                                             "Delete - Press Delete to delete the User's details.  This button will appear if you swipe left on a user."
            ]
        ]
    }
    
    func showHelpPanel() {
        let helpPanel = HelpPanelViewController()
        helpPanel.modalPresentationStyle = .custom
        helpPanel.dataSource = self
        present(helpPanel, animated: true, completion: nil)
    }
}
