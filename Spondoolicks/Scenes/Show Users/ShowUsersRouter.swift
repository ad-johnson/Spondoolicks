//
//  ShowUsersRouter.swift
//  Created by Andrew Johnson on 23/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

@objc protocol ShowUsersRoutingLogic {
    func routeToShowMaintainUser(segue: UIStoryboardSegue?)
    func routeToShowDashboard(segue: UIStoryboardSegue?)
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
    
    func routeToShowDashboard(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let tabBarController = segue.destination as! UITabBarController
            if let destinationVC = (tabBarController.viewControllers?[0]) as? DashboardViewController {
                var destinationDS = destinationVC.router!.dataStore!
                passDataToDashboard(source: dataStore!, destination: &destinationDS)
            } else {
                fatalError("UITabBarController for Dashboard did not create a Dashboard VC as its first View Controller")
            }
        } else {
            let storyboard = UIStoryboard(name: Global.Identifier.Storyboard.MAIN, bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: Global.Identifier.ViewController.DASHBOARD_VC) as! DashboardViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToDashboard(source: dataStore!, destination: &destinationDS)
            navigateToDashboard(source: viewController!, destination: destinationVC)
        }

    }

    // MARK: - Navigation
    func navigateToMaintainUser(source: ShowUsersViewController, destination: MaintainUserViewController) {
        source.show(destination, sender: nil)
    }
  
    func navigateToDashboard(source: ShowUsersViewController, destination: DashboardViewController) {
        source.show(destination, sender: nil)
    }
    
    // MARK: - Passing data
    func passDataToMaintainUser(source: ShowUsersDataStore, destination: inout MaintainUserDataStore) {
        if let indexPath = viewController?.userBeingActioned, let users = source.users {
            destination.userBeingMaintained = users[indexPath.row]
            destination.users = users
        } else {
            destination.userBeingMaintained = nil
        }
    }
    
    func passDataToDashboard(source: ShowUsersDataStore, destination: inout DashboardDataStore) {
        if let indexPath = viewController?.userBeingActioned, let users = source.users {
            destination.user = users[indexPath.row]
        } else {
            fatalError("Trying to show the Dashboard without having selected a User.")
        }
    }
}
