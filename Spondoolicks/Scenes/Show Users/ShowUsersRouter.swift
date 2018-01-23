//
//  ShowUsersRouter.swift
//  Created by Andrew Johnson on 23/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

@objc protocol ShowUsersRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ShowUsersDataPassing {
    var dataStore: ShowUsersDataStore? { get }
}

class ShowUsersRouter: NSObject, ShowUsersRoutingLogic, ShowUsersDataPassing {
    // MARK: - Properties
    weak var viewController: ShowUsersViewController?
    var dataStore: ShowUsersDataStore?
  
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
  
    //func navigateToSomewhere(source: ShowUsersViewController, destination: SomewhereViewController) {
    //    source.show(destination, sender: nil)
    //}
  
    // MARK: - Passing data
    //func passDataToSomewhere(source: ShowUsersDataStore, destination: inout SomewhereDataStore) {
    //    destination.name = source.name
    //}
}
