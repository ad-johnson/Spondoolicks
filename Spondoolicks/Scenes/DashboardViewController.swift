//
//  DashboardViewController.swift
//
//  Created by Andrew Johnson on 21/02/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol DashboardDisplayLogic: class {
    func displaySomething(viewModel: Dashboard.Something.ViewModel)
}

class DashboardViewController: UIViewController, DashboardDisplayLogic {
    // MARK: - Properties
    var interactor: DashboardBusinessLogic?
    var router: (NSObjectProtocol & DashboardRoutingLogic & DashboardDataPassing)?
    
    // MARK: - IBOutlets
    @IBOutlet weak var placeholder: UILabel!
    
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
        let interactor = DashboardInteractor()
        let presenter = DashboardPresenter()
        let router = DashboardRouter()
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
        placeholder.text = interactor?.userName()
    }
    
    // MARK: - View handling
    
    // MARK: - IBActions
    //@IBOutlet weak var nameTextField: UITextField!
    
    // MARK: - Use cases
    func doSomething() {
        let request = Dashboard.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: Dashboard.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
