//
//  ShowUsersInteractor.swift
//
//  Created by Andrew Johnson on 23/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol ShowUsersBusinessLogic {
    func doSomething(request: ShowUsers.Something.Request)
}

protocol ShowUsersDataStore {
    //var name: String { get set }
}

class ShowUsersInteractor: ShowUsersBusinessLogic, ShowUsersDataStore {
    // MARK: - Properties
    var presenter: ShowUsersPresentationLogic?
    var worker: ShowUsersWorker?
    //var name: String = ""
  
    // MARK: - Use Cases
    func doSomething(request: ShowUsers.Something.Request) {
        worker = ShowUsersWorker()
        worker?.doSomeWork()
    
        let response = ShowUsers.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
