//
//  ShowUsersRouter.swift
//  Created by Andrew Johnson on 23/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

@objc protocol ShowUsersRoutingLogic {
    func routeToShowMaintainUser(segue: UIStoryboardSegue?)
}

protocol ShowUsersDataPassing {
    var dataStore: ShowUsersDataStore? { get }
}

class ShowUsersRouter: NSObject, ShowUsersRoutingLogic, ShowUsersDataPassing {
    // MARK: - Properties
    weak var viewController: ShowUsersViewController?
    var dataStore: ShowUsersDataStore?
  
    // MARK: - Routing
  
    func routeToShowMaintainUser(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! MaintainUserViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToMaintainUser(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: Global.Identifier.Storyboard.MAIN, bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: Global.Identifier.ViewController.MAINTAIN_USER_VC) as! MaintainUserViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToMaintainUser(source: dataStore!, destination: &destinationDS)
            navigateToMaintainUser(source: viewController!, destination: destinationVC)
        }
    }

    // MARK: - Navigation
  
    func navigateToMaintainUser(source: ShowUsersViewController, destination: MaintainUserViewController) {
        source.show(destination, sender: nil)
    }
  
    // MARK: - Passing data
    func passDataToMaintainUser(source: ShowUsersDataStore, destination: inout MaintainUserDataStore) {
        if let indexPath = viewController?.userBeingActioned, let users = source.users {
            destination.userBeingMaintained = users[indexPath.row]
        } else {
            destination.userBeingMaintained = nil
        }
    }
}
