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
    
    // MARK: - IBOutlets
    @IBOutlet weak var spondoolicksLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    
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
        doSomething()
    }
    
    // MARK: - View handling
    func setupView() {
        if let font = UIFont(name: "OpenSans-SemiBold", size: 36) {
            if traitCollection.userInterfaceIdiom == .phone {
                spondoolicksLabel.font = UIFontMetrics(forTextStyle: .title2).scaledFont(for: font, maximumPointSize: Global.FontInfo.maxPointSizeForIPhone) // Any bigger on an iPhone and it runs off the screen edges.
            } else {
                spondoolicksLabel.font = UIFontMetrics(forTextStyle: .title2).scaledFont(for: font)
            }
        }
        if let font = UIFont(name: "OpenSans-SemiBold", size: 20) {
            introLabel.font = UIFontMetrics.default.scaledFont(for: font)
        }
    }
    
    // MARK: - IBActions
    
    // MARK: - Use cases
    func doSomething() {
        let request = Home.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: Home.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
