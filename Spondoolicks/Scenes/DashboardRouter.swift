//
//  DashboardRouter.swift
//  Created by Andrew Johnson on 21/02/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

@objc protocol DashboardRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol DashboardDataPassing {
    var dataStore: DashboardDataStore? { get }
}

class DashboardRouter: NSObject, DashboardRoutingLogic, DashboardDataPassing {
    // MARK: - Properties
    weak var viewController: DashboardViewController?
    var dataStore: DashboardDataStore?
  
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
  
    //func navigateToSomewhere(source: DashboardViewController, destination: SomewhereViewController) {
    //    source.show(destination, sender: nil)
    //}
  
    // MARK: - Passing data
    //func passDataToSomewhere(source: DashboardDataStore, destination: inout SomewhereDataStore) {
    //    destination.name = source.name
    //}
}