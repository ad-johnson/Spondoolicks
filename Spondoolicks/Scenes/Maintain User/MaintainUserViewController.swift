//
//  MaintainUserViewController.swift
//
//  Created by Andrew Johnson on 27/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol MaintainUserDisplayLogic: class {
    func displayUser(viewModel: MaintainUser.GetUser.ViewModel?)
}

class MaintainUserViewController: UIViewController, UITextFieldDelegate, MaintainUserDisplayLogic {
    // MARK: - Properties
    var interactor: MaintainUserBusinessLogic?
    var router: (NSObjectProtocol & MaintainUserRoutingLogic & MaintainUserDataPassing)?
    var isAddingUser = true
    
    // MARK: - IBOutlets
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
        
        getUser()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        flowLayout.invalidateLayout()
    }

    
    // MARK: - IBActions
    
    // MARK: - Use cases
    func getUser() {
        let request = MaintainUser.GetUser.Request()
        interactor?.getUser(request: request)
    }
    
    // MARK: - Use case resonses
    func displayUser(viewModel: MaintainUser.GetUser.ViewModel?) {
        if let user = viewModel?.displayedUser {
            self.navigationItem.title = "Change User"
            userName.text = user.userName
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
}

extension MaintainUserViewController: UICollectionViewDelegate {
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
