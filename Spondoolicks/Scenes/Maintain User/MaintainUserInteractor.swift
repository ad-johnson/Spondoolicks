//
//  MaintainUserInteractor.swift
//
//  Created by Andrew Johnson on 27/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol MaintainUserBusinessLogic {
    func getUser(request: MaintainUser.GetUser.Request)
}

protocol MaintainUserDataStore {
    var userBeingMaintained: TempUser? { get set }
}

class MaintainUserInteractor: MaintainUserBusinessLogic, MaintainUserDataStore {
    // MARK: - Properties
    var presenter: MaintainUserPresentationLogic?
    var worker: MaintainUserWorker?
    var userBeingMaintained: TempUser?
  
    // MARK: - Use Cases
    func getUser(request: MaintainUser.GetUser.Request) {
        let response = MaintainUser.GetUser.Response(user: userBeingMaintained)
        presenter?.presentUser(response: response)
    }
}
