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
}

class ShowUsersViewController: UIViewController, ShowUsersDisplayLogic {
    // MARK: - Properties
    var interactor: ShowUsersBusinessLogic?
    var router: (NSObjectProtocol & ShowUsersRoutingLogic & ShowUsersDataPassing)?
    var displayedUsers: [ShowUsers.FindUsers.ViewModel.DisplayedUser] = []
    
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

    // MARK: - IBActions
    
    // MARK: - Use cases
    
    func findUsers() {
        let request = ShowUsers.FindUsers.Request()
        interactor?.findUsers(request: request)
    }
    
    func displayUsers(viewModel: ShowUsers.FindUsers.ViewModel) {
        displayedUsers = viewModel.displayedUsers
        userTable.reloadData()
    }
}

extension ShowUsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // do something here
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
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
