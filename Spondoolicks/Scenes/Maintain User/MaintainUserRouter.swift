//
//  MaintainUserRouter.swift
//  Created by Andrew Johnson on 27/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

@objc protocol MaintainUserRoutingLogic {
    func routeToShowUsers(segue: UIStoryboardSegue?)
}

protocol MaintainUserDataPassing {
    var dataStore: MaintainUserDataStore? { get }
}

class MaintainUserRouter: NSObject, MaintainUserRoutingLogic, MaintainUserDataPassing {
    // MARK: - Properties
    weak var viewController: MaintainUserViewController?
    var dataStore: MaintainUserDataStore?
  
    // MARK: - Routing
    func routeToShowUsers(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! ShowUsersViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToShowUsers(source: dataStore!, destination: &destinationDS)
        } else {
            let index = viewController!.navigationController!.viewControllers.count - 2
            let destinationVC = viewController?.navigationController?.viewControllers[index] as! ShowUsersViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToShowUsers(source: dataStore!, destination: &destinationDS)
            navigateToShowUsers(source: viewController!, destination: destinationVC)
        }
    }

    // MARK: - Navigation
    func navigateToShowUsers(source: MaintainUserViewController, destination: ShowUsersViewController) {
        source.navigationController?.popViewController(animated: true)
    }
  
    // MARK: - Passing data
    func passDataToShowUsers(source: MaintainUserDataStore, destination: inout ShowUsersDataStore) {
        // No data to pass
    }
}
