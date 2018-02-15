//
//  Provides business logic for the Show Users Use Cases.
//
//  Created by Andrew Johnson on 23/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol ShowUsersBusinessLogic {
    func findUsers(request: ShowUsers.FindUsers.Request)
    func deleteUser(request: ShowUsers.DeleteUser.Request)
}

protocol ShowUsersDataStore {
    var users: [User]? { get set }
    var parent: Parent? { get set }
}

class ShowUsersInteractor: ShowUsersBusinessLogic, ShowUsersDataStore {
    // MARK: - Properties
    var presenter: ShowUsersPresentationLogic?
    var worker: ShowUsersWorker = ShowUsersWorker()
    var users: [User]?
    var parent: Parent?
    
    // MARK: - Use Cases
    func findUsers(request: ShowUsers.FindUsers.Request) {
        worker.findUsers(completion: usersFound)
    }
    
    func deleteUser(request: ShowUsers.DeleteUser.Request) {
        let name = request.userName
        guard let users = users else { return }
        
        guard let index = users.index(where: { $0.name == name}) else {
            let response = ShowUsers.DeleteUser.Response(error: Global.Errors.UserMaintenanceError.userNotFound)
            presenter?.presentDeleteUserResult(response: response)
            return
        }
        let user = users[index]
        worker.deleteUser(user, id: index, completion: userDeleted)
    }
    
    // MARK: - Use case callbacks
    func usersFound(users: [User]) {
        self.users = users
        let response = ShowUsers.FindUsers.Response(users: users)
        presenter?.presentFoundUsers(response: response)
    }
    
    func userDeleted(success: Bool, id: Int) {
        if success {
            users?.remove(at: id)
            let response = ShowUsers.DeleteUser.Response(error: nil)
            presenter?.presentDeleteUserResult(response: response)
        } else {
            let response = ShowUsers.DeleteUser.Response(error: Global.Errors.UserMaintenanceError.userNotFound)
            presenter?.presentDeleteUserResult(response: response)
        }
    }
}
