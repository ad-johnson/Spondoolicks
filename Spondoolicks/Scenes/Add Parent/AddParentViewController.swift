//  AddParentViewController.swift
//
//  Created by Andrew Johnson on 08/02/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol AddParentDisplayLogic: class {
    func displayAddParentResult(viewModel: AddParent.AddParent.ViewModel)
}

class AddParentViewController: UIViewController, AddParentDisplayLogic, PinCodeDelegate {
    // MARK: - Properties
    var interactor: AddParentBusinessLogic?
    var router: (NSObjectProtocol & AddParentRoutingLogic & AddParentDataPassing)?
    var pickerVC: PinCodeGeneratorViewController?
    var currentPin: String?
    
    // MARK: - IBOutlets
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var parentText: UILabel!
    @IBOutlet weak var helpButton: UIBarButtonItem!
    
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
        let interactor = AddParentInteractor()
        let presenter = AddParentPresenter()
        let router = AddParentRouter()
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
        parentText.font = FontHelper.getFontFor(.body, traitCollection: traitCollection)
        configureLabelText()
        pickerVC = childViewControllers.first as? PinCodeGeneratorViewController
        pickerVC?.delegate = self
    }
    
    func configureLabelText() {
        if traitCollection.preferredContentSizeCategory.isAccessibilityCategory {
            parentText.text =
            "Set a PIN to allow Parental control.  More information in the help text."
            helpButton.isEnabled = true
            helpButton.tintColor = nil
        } else {
            parentText.text =
            "Set a PIN to allow Parental control.\n\nA parent can view any of their childs’ accounts, even when protected with a PIN number.  Additionally, if a child forgets their PIN, the parent can reset it.\n\nYou can always add a parent later, or change the parent PIN, through settings."
            helpButton.isEnabled = false
            helpButton.tintColor = UIColor.clear
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let isAccessibilityCategory = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        if isAccessibilityCategory != previousTraitCollection?.preferredContentSizeCategory.isAccessibilityCategory {
            configureLabelText()
        }
    }

    // MARK: - IBActions
    @IBAction func helpTapped(_ sender: UIBarButtonItem) {
        showHelpPanel()
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        addParent()
    }
    
    // MARK: - Use cases
    func newPinSelected(_ newPin: String) {
        print("New PIN selected: \(newPin)")
        currentPin = newPin
        saveButton.isEnabled = true
    }
    
    func addParent() {
        guard let newPin = currentPin else { return }
        
        let request = AddParent.AddParent.Request(newPin: newPin)
        interactor?.addParent(request: request)
    }
    
    // MARK: - Use cases: responses
    func displayAddParentResult(viewModel: AddParent.AddParent.ViewModel) {
        let resultModal = ResultModalViewController()
        resultModal.success = false
        resultModal.completion = { self.router?.routeToHomeVC(segue: nil) }
        resultModal.modalPresentationStyle = .custom
        present(resultModal, animated: true, completion: nil )
    }
}

extension AddParentViewController: HelpPanelDataSource, HelpPanelLauncherHelper {
    enum Subtitle: String {
        case why = "Why?"
    }
    func helpPanelTitle() -> String {
        return "Add Parent"
    }
    
    func subtitles() -> [String] {
        return [Subtitle.why.rawValue]
    }
    
    func helpSectionEntries() -> [String : [String]] {
        return [Subtitle.why.rawValue : ["A parent can view any of their childs’ accounts, even when protected with a PIN number.  This allows the parent to keep an eye on their spending.",
            "Additionally, if a child forgets their PIN, the parent can reset it.",
            "You can always add a parent later, or change the parent PIN, through settings."]
        ]
    }
    
    
}
