//
//  HomeRouter.swift
//  Created by Andrew Johnson on 18/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

@objc protocol HomeRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    // MARK: - Properties
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
  
    // MARK: - Routing
    func routeToShowUsers(segue: UIStoryboardSegue) {
        //    if let segue = segue {
        //        let destinationVC = segue.destination as! UsersViewController
        //        var destinationDS = destinationVC.router!.dataStore!
        //        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
        //    } else {
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
        //        var destinationDS = destinationVC.router!.dataStore!
        //        passDataToSomewhere(source: dataStore!, destination: &destinationDS)
        //        navigateToSomewhere(source: viewController!, destination: destinationVC)
        //    }
    }
  
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
  
    //func navigateToSomewhere(source: HomeViewController, destination: SomewhereViewController) {
    //    source.show(destination, sender: nil)
    //}
  
    // MARK: - Passing data
    //func passDataToSomewhere(source: HomeDataStore, destination: inout SomewhereDataStore) {
    //    destination.name = source.name
    //}
}
