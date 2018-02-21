//
//  DashboardInteractor.swift
//
//  Created by Andrew Johnson on 21/02/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol DashboardBusinessLogic {
    func doSomething(request: Dashboard.Something.Request)
    func userName() -> String
}

protocol DashboardDataStore {
    var user: User? { get set }
}

class DashboardInteractor: DashboardBusinessLogic, DashboardDataStore {
    // MARK: - Properties
    var presenter: DashboardPresentationLogic?
    var worker: DashboardWorker?
    var user: User?
  
    // MARK: - Use Cases
    func userName() -> String {
        return user!.name
    }
    
    func doSomething(request: Dashboard.Something.Request) {
//        worker = DashboardWorker()
//        worker?.doSomeWork()
//
//        let response = Dashboard.Something.Response()
//        presenter?.presentSomething(response: response)
    
    }
}
