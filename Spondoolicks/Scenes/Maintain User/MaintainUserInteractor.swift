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
    var userBeingMaintained: User? { get set }
    var users: [User]? { get set }
}

class MaintainUserInteractor: MaintainUserBusinessLogic, MaintainUserDataStore {
    // MARK: - Properties
    var presenter: MaintainUserPresentationLogic?
    lazy var worker: MaintainUserWorker = { MaintainUserWorker() }()
    var userBeingMaintained: User?
    var users: [User]?
    
    // MARK: - Use cases
    func getUser(request: MaintainUser.GetUser.Request) {
        let response = MaintainUser.GetUser.Response(user: userBeingMaintained)
        presenter?.presentUser(response: response)
    }
    
    func addUser(request: MaintainUser.UpdateUser.Request) {
        guard let _ = users?.index(where: { $0.name == request.userName }) else {
            worker.addUser(name: request.userName, avatarImage: request.avatarImage, completion: userAdded)
            return
        }
        let response = MaintainUser.UpdateUser.Response(error: Global.Errors.UserMaintenanceError.userAlreadyExists)
        presenter?.presentUpdateUserResult(response: response)
    }
    
    func changeUser(request: MaintainUser.UpdateUser.Request) {
        if let user = userBeingMaintained {
            // Must have a unique name if it has been changed
            guard let _ = users?.index(where: { $0.name == request.userName }), user.name != request.userName else {
                user.name = request.userName
                user.avatarImage = request.avatarImage
                worker.changeUser(user, completion: userUpdated)
                return
            }
            let response = MaintainUser.UpdateUser.Response(error: Global.Errors.UserMaintenanceError.userAlreadyExists)
            presenter?.presentUpdateUserResult(response: response)
        } else {
            fatalError("Change User called with a User that doesn't exist.")
        }
    }
    
    // MARK: - Use case callbacks
    func userAdded(_ user: User) {
        if let index = users?.index(where: { $0.name >= user.name } ) {
            users?.insert(user, at: index)
        } else {
            users?.append(user)
        }
        let response = MaintainUser.UpdateUser.Response(error: nil)
        presenter?.presentUpdateUserResult(response: response)
    }
    
    func userUpdated(_ success: Bool) {
        let response = MaintainUser.UpdateUser.Response(error: nil)
        presenter?.presentUpdateUserResult(response: response)
    }
}
