//
//  HomeInteractor.swift
//
//  Created by Andrew Johnson on 18/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    func doSomething(request: Home.Something.Request)
}

protocol HomeDataStore {
    //var name: String { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    // MARK: - Properties
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    //var name: String = ""
  
    // MARK: - Use Cases
    func doSomething(request: Home.Something.Request) {
        worker = HomeWorker()
        worker?.doSomeWork()
    
        let response = Home.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
