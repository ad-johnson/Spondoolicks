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
    var users: [TempUser]? { get set }
    var parent: Parent? { get set }
}

class ShowUsersInteractor: ShowUsersBusinessLogic, ShowUsersDataStore {
    // MARK: - Properties
    var presenter: ShowUsersPresentationLogic?
    var worker: ShowUsersWorker = ShowUsersWorker()
    var users: [TempUser]?
    var parent: Parent?
    
    // MARK: - Use Cases
    func findUsers(request: ShowUsers.FindUsers.Request) {
        worker.findUsers(callback: usersFound)
    }
    
    func deleteUser(request: ShowUsers.DeleteUser.Request) {
        worker.deleteUser(userId: request.userId, callback: userDeleted)
    }
    
    // MARK: - Use case callbacks
    func usersFound(users: [TempUser]) {
        self.users = users
        let response = ShowUsers.FindUsers.Response(users: users)
        presenter?.presentFoundUsers(response: response)
    }
    
    func userDeleted(newUsers: [TempUser], error: Error?) {
        if let error = error {
            let response = ShowUsers.DeleteUser.Response(error: error)
            presenter?.presentDeleteUserResult(response: response)
        } else {
            users = newUsers
            let response = ShowUsers.DeleteUser.Response(error: nil)
            presenter?.presentDeleteUserResult(response: response)
        }
    }
}
