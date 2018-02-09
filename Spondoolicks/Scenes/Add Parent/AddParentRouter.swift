//
//  AddParentRouter.swift
//  Created by Andrew Johnson on 08/02/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

@objc protocol AddParentRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol AddParentDataPassing {
    var dataStore: AddParentDataStore? { get }
}

class AddParentRouter: NSObject, AddParentRoutingLogic, AddParentDataPassing {
    // MARK: - Properties
    weak var viewController: AddParentViewController?
    var dataStore: AddParentDataStore?
  
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
  
    //func navigateToSomewhere(source: AddParentViewController, destination: SomewhereViewController) {
    //    source.show(destination, sender: nil)
    //}
  
    // MARK: - Passing data
    //func passDataToSomewhere(source: AddParentDataStore, destination: inout SomewhereDataStore) {
    //    destination.name = source.name
    //}
}
