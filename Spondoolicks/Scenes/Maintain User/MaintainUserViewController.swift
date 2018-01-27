//
//  MaintainUserViewController.swift
//
//  Created by Andrew Johnson on 27/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol MaintainUserDisplayLogic: class {
    func displaySomething(viewModel: MaintainUser.Something.ViewModel)
}

class MaintainUserViewController: UIViewController, UITextFieldDelegate, MaintainUserDisplayLogic {
    // MARK: - Properties
    var interactor: MaintainUserBusinessLogic?
    var router: (NSObjectProtocol & MaintainUserRoutingLogic & MaintainUserDataPassing)?
    
    // MARK: - IBOutlets
    @IBOutlet weak var userName: spBorderedTextField!
    
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
        
        if let colour = UIColor(named: "sp Grey") {
//            let semi = colour.withAlphaComponent(0.5)
            userName.attributedPlaceholder = NSAttributedString(string: "My name is", attributes: [NSAttributedStringKey.foregroundColor: colour.withAlphaComponent(0.5) ])
        } else {
            userName.attributedPlaceholder = NSAttributedString(string: "My name is", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray.withAlphaComponent(0.5) ])
        }
    }
    
    // MARK: - IBActions
    //@IBOutlet weak var nameTextField: UITextField!
    
    // MARK: - Use cases
    func doSomething() {
        let request = MaintainUser.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: MaintainUser.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
