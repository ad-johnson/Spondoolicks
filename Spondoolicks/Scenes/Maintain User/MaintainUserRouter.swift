//
//  MaintainUserRouter.swift
//  Created by Andrew Johnson on 27/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

@objc protocol MaintainUserRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol MaintainUserDataPassing {
    var dataStore: MaintainUserDataStore? { get }
}

class MaintainUserRouter: NSObject, MaintainUserRoutingLogic, MaintainUserDataPassing {
    // MARK: - Properties
    weak var viewController: MaintainUserViewController?
    var dataStore: MaintainUserDataStore?
  
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
  
    //func navigateToSomewhere(source: MaintainUserViewController, destination: SomewhereViewController) {
    //    source.show(destination, sender: nil)
    //}
  
    // MARK: - Passing data
    //func passDataToSomewhere(source: MaintainUserDataStore, destination: inout SomewhereDataStore) {
    //    destination.name = source.name
    //}
}
