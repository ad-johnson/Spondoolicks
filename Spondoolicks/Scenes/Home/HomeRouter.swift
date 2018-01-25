//
//  HomeRouter.swift
//  Created by Andrew Johnson on 18/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

@objc protocol HomeRoutingLogic {
    func routeToShowUsers(segue: UIStoryboardSegue?)
    func routeToShowSettings(segue: UIStoryboardSegue?)
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    // MARK: - Properties
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
  
    // MARK: - Routing
    func routeToShowUsers(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! ShowUsersViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToShowUsers(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: Global.Identifier.Storyboard.MAIN, bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: Global.Identifier.ViewController.SHOW_USERS_VC) as! ShowUsersViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToShowUsers(source: dataStore!, destination: &destinationDS)
            navigateToShowUsers(source: viewController!, destination: destinationVC)
        }
    }
  
    func routeToShowSettings(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! SettingsViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToSettings(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: Global.Identifier.Storyboard.MAIN, bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: Global.Identifier.ViewController.SETTINGS_VC) as! SettingsViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToSettings(source: dataStore!, destination: &destinationDS)
            navigateToSettings(source: viewController!, destination: destinationVC)
        }
    }
    
    // MARK: - Navigation
    func navigateToShowUsers(source: HomeViewController, destination: ShowUsersViewController) {
        source.show(destination, sender: nil)
    }
  
    func navigateToSettings(source: HomeViewController, destination: SettingsViewController) {
        source.show(destination, sender: nil)
    }
    
    // MARK: - Passing data
    func passDataToShowUsers(source: HomeDataStore, destination: inout ShowUsersDataStore) {
        // Nothing to pass
    }
    
    func passDataToSettings(source: HomeDataStore, destination: inout SettingsDataStore) {
        // Nothing to pass
    }
}
