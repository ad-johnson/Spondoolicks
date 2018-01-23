//
//  SettingsRouter.swift
//  Created by Andrew Johnson on 23/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

@objc protocol SettingsRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol SettingsDataPassing {
    var dataStore: SettingsDataStore? { get }
}

class SettingsRouter: NSObject, SettingsRoutingLogic, SettingsDataPassing {
    // MARK: - Properties
    weak var viewController: SettingsViewController?
    var dataStore: SettingsDataStore?
  
    // MARK: - Routing
  
    //func routeToSomewhere(segue: UIStoryboardSegue?) {
    //    if let segue = segue {
    //        let destinationVC = segue.destination as! SomewhereViewController
    //        var destinationDS = destinationVC.router!.dataStore!
    //        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    } else {
    //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //        let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //        var destinationDS = destinationVC.router!.dataStore!
    //        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //        navigateToSomewhere(source: viewController!, destination: destinationVC)
    //    }
    //}

    // MARK: - Navigation
  
    //func navigateToSomewhere(source: SettingsViewController, destination: SomewhereViewController) {
    //    source.show(destination, sender: nil)
    //}
  
    // MARK: - Passing data
    //func passDataToSomewhere(source: SettingsDataStore, destination: inout SomewhereDataStore) {
    //    destination.name = source.name
    //}
}
