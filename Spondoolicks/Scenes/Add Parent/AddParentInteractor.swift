//
//  Handles all business logic for adding a parent.
//
//  Created by Andrew Johnson on 08/02/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import Foundation

protocol AddParentBusinessLogic {
    func addParent(request: AddParent.AddParent.Request)
}

protocol AddParentDataStore {
    var parent: Parent? { get set }
}

class AddParentInteractor: AddParentBusinessLogic, AddParentDataStore {
    // MARK: - Properties
    var presenter: AddParentPresentationLogic?
    lazy var worker = AddParentWorker()
    var parent: Parent?
    
    // MARK: - Use Cases
    func addParent(request: AddParent.AddParent.Request) {
        worker.addParent(newPin: request.newPin, completion: parentAdded)
    }
    
    // MARK - Callbacks
    func parentAdded(_ parent: Parent) {
        self.parent = parent
        
        let response = AddParent.AddParent.Response(parent: parent)
        presenter?.presentAddParentResult(response: response)
    }
}
