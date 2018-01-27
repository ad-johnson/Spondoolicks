//
//  MaintainUserInteractor.swift
//
//  Created by Andrew Johnson on 27/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol MaintainUserBusinessLogic {
    func doSomething(request: MaintainUser.Something.Request)
}

protocol MaintainUserDataStore {
    //var name: String { get set }
}

class MaintainUserInteractor: MaintainUserBusinessLogic, MaintainUserDataStore {
    // MARK: - Properties
    var presenter: MaintainUserPresentationLogic?
    var worker: MaintainUserWorker?
    //var name: String = ""
  
    // MARK: - Use Cases
    func doSomething(request: MaintainUser.Something.Request) {
        worker = MaintainUserWorker()
        worker?.doSomeWork()
    
        let response = MaintainUser.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
