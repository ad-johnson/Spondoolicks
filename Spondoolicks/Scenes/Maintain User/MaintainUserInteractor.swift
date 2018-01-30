//
//  Handle business logic for maintaining users.
//
//  Created by Andrew Johnson on 27/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol MaintainUserBusinessLogic {
    func getUser(request: MaintainUser.GetUser.Request)
    func addUser(request: MaintainUser.UpdateUser.Request)
    func changeUser(request: MaintainUser.UpdateUser.Request)
}

protocol MaintainUserDataStore {
    var userBeingMaintained: TempUser? { get set }
}

class MaintainUserInteractor: MaintainUserBusinessLogic, MaintainUserDataStore {
    // MARK: - Properties
    var presenter: MaintainUserPresentationLogic?
    lazy var worker: MaintainUserWorker = { MaintainUserWorker() }()
    var userBeingMaintained: TempUser?
  
    // MARK: - Use cases
    func getUser(request: MaintainUser.GetUser.Request) {
        let response = MaintainUser.GetUser.Response(user: userBeingMaintained)
        presenter?.presentUser(response: response)
    }
    
    func addUser(request: MaintainUser.UpdateUser.Request) {
        let user = TempUser(userId: TempUser.users.count, userName: request.userName, avatarImage: request.avatarImage)
        worker.addUser(user: user, callback: userUpdated)
    }
    
    func changeUser(request: MaintainUser.UpdateUser.Request) {
        if let userId = userBeingMaintained?.userId {
            let user = TempUser(userId: userId, userName: request.userName, avatarImage: request.avatarImage)
            worker.changeUser(user: user, callback: userUpdated)
        } else {
            fatalError("Change User called with a User that has no ID.")
        }
    }
    
    // MARK: - Use case callbacks
    func userUpdated(error: Error?) {
        let response = MaintainUser.UpdateUser.Response(error: error)
        presenter?.presentUpdateUserResult(response: response)
    }
}
