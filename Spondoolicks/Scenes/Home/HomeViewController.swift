//
//  Starting screen for the app.
//
//  Created by Andrew Johnson on 18/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: class {
    func displaySomething(viewModel: Home.Something.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    // MARK: - Properties
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    var testAddParent = true
    
    // MARK: - IBOutlets
    @IBOutlet weak var spondoolicksLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var optionsTable: UITableView!
    
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
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
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
        optionsTable.delegate = self
        optionsTable.dataSource = self
        optionsTable.isHidden = true
        
        spondoolicksLabel.font = FontHelper.getFontFor(.headline, traitCollection: traitCollection)
        introLabel.font = FontHelper.getFontFor(.title2, traitCollection: traitCollection)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let indexPath = IndexPath(row: 0, section: 0)
        optionsTable.scrollToRow(at: indexPath, at: .top, animated: false)
    }

    func appInitialised() {
        optionsTable.isHidden = false
        addParentIfFirstUse()
    }
    
    // MARK: - IBActions
    
    // MARK: - Use cases
    func addParentIfFirstUse() {
        var userDefaults = UserDefaultsHelper()
        if userDefaults.isFirstUse {
            userDefaults.isFirstUse = false
            performSegue(withIdentifier: Global.Segue.ADD_PARENT, sender: self)
        }
    }
    
    func usersSelected() {
        performSegue(withIdentifier: Global.Segue.SHOW_USERS, sender: self)
    }
    
    func settingsSelected() {
        performSegue(withIdentifier: Global.Segue.SHOW_SETTINGS, sender: self)
    }
    
    // TODO: - Re-factor these two methods out
    func doSomething() {
        let request = Home.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: Home.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}

// MARK: - Collection View
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Global.Identifier.Cell.OPTION_CELL, for: indexPath) as? OptionCell {
            if indexPath.row == 0 {
                cell.configureForUsers()
            }
            
            if indexPath.row == 1 {
                cell.configureForSettings()
            }
            
            return cell
            
        } else {
            fatalError("Home TableView cell at row \(indexPath.row) is not an \(Global.Identifier.Cell.OPTION_CELL)")
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            usersSelected()
        } else {
            settingsSelected()
        }
    }
}

extension HomeViewController {
    // TODO: - finalise implementation of rollback handler
    func handleCoreDataRollback(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            print("Error occured in saving Core Data context:")
            print("In action: \(userInfo[Global.Notifications.UserInfo.identifier]!)")
            print("Error: \(userInfo[Global.Notifications.UserInfo.error]!)")
        } else {
            print("Unidentified error occurred in saving Core Data entity.  Updates rolled back.")
        }
    }
}

