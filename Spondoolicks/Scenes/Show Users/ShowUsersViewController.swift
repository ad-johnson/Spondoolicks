//
//  ShowUsersViewController.swift
//
//  Created by Andrew Johnson on 23/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol ShowUsersDisplayLogic: class {
    func displaySomething(viewModel: ShowUsers.Something.ViewModel)
}

class ShowUsersViewController: UIViewController, ShowUsersDisplayLogic {
    // MARK: - Properties
    var interactor: ShowUsersBusinessLogic?
    var router: (NSObjectProtocol & ShowUsersRoutingLogic & ShowUsersDataPassing)?
    
    // MARK: - IBOutlets
    
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
        doSomething()
    }
    
    // MARK: - View handling
    
    // MARK: - IBActions
    //@IBOutlet weak var nameTextField: UITextField!
    
    // MARK: - Use cases
    func doSomething() {
        let request = ShowUsers.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: ShowUsers.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
