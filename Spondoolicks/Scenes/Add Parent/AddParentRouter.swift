//  Provides routing and data passing functionality
//
//  Created by Andrew Johnson on 08/02/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

@objc protocol AddParentRoutingLogic {
    func routeToHomeVC(segue: UIStoryboardSegue?)
}

protocol AddParentDataPassing {
    var dataStore: AddParentDataStore? { get }
}

class AddParentRouter: NSObject, AddParentRoutingLogic, AddParentDataPassing {
    // MARK: - Properties
    weak var viewController: AddParentViewController?
    var dataStore: AddParentDataStore?
  
    // MARK: - Routing
  
    func routeToHomeVC(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! HomeViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToHomeVC(source: dataStore!, destination: &destinationDS)
        } else {
            let index = viewController!.navigationController!.viewControllers.count - 2
            let destinationVC = viewController?.navigationController?.viewControllers[index] as! HomeViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToHomeVC(source: dataStore!, destination: &destinationDS)
            navigateToHomeVC(source: viewController!, destination: destinationVC)
        }
    }

    // MARK: - Navigation
    func navigateToHomeVC(source: AddParentViewController, destination: HomeViewController) {
        source.navigationController?.popViewController(animated: true)
    }
  
    // MARK: - Passing data
    func passDataToHomeVC(source: AddParentDataStore, destination: inout HomeDataStore) {
        destination.parent = source.parent
    }
}
