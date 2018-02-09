//
//  AddParentInteractor.swift
//
//  Created by Andrew Johnson on 08/02/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol AddParentBusinessLogic {
    func getParent(request: AddParent.GetParent.Request)
}

protocol AddParentDataStore {
    //var name: String { get set }
}

class AddParentInteractor: AddParentBusinessLogic, AddParentDataStore {
    // MARK: - Properties
    var presenter: AddParentPresentationLogic?
    lazy var worker = AddParentWorker()
    //var name: String = ""
  
    // MARK: - Use Cases
    func getParent(request: AddParent.GetParent.Request) {
        worker.getParent()
    
        let response = AddParent.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
