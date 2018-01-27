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
    var userBeingDeleted: IndexPath?
    
    // MARK: - IBOutlets
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
        if let userBeingDeleted = userBeingDeleted, let cellBeingDeleted = userTable.cellForRow(at: userBeingDeleted) {
            let userName = displayedUsers[userBeingDeleted.row].userName
            
            let alert = UIAlertController(title: "Delete User", message: "Are you sure you want to permanently delete \(userName)?  There is no going back!", preferredStyle: .actionSheet)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: deleteUser)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) in
                    self.userBeingDeleted = nil
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
    @IBAction func addUser(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Global.Segue.MAINTAIN_USER, sender: self)
    }
    
    // MARK: - Use cases: requests
    
    func findUsers() {
        let request = ShowUsers.FindUsers.Request()
        interactor?.findUsers(request: request)
    }
    
    func deleteUser(alertAction: UIAlertAction?) {
        if let userBeingDeleted = userBeingDeleted {
            let userId = displayedUsers[userBeingDeleted.row].userId
            interactor?.deleteUser(request: ShowUsers.DeleteUser.Request(userId: userId))
        }
    }
    
    // MARK: - Use cases: responses
    func displayUsers(viewModel: ShowUsers.FindUsers.ViewModel) {
        displayedUsers = viewModel.displayedUsers
        userTable.reloadData()
    }
    
    func userDeleted(viewModel: ShowUsers.DeleteUser.ViewModel) {
        if let indexPath = userBeingDeleted {
            if let _ = viewModel.error {
                let name = displayedUsers[indexPath.row].userName
                displayError("Could not delete user \(name).  Something went wrong.")
            } else {
                userTable.beginUpdates()
                displayedUsers.remove(at: indexPath.row)
                userTable.deleteRows(at: [indexPath], with: .automatic)
                userBeingDeleted = nil
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            userBeingDeleted = indexPath
            confirmDelete()
        }
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
