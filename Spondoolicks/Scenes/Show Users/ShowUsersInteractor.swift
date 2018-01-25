//
//  Provides business logic for the Show Users Use Cases.
//
//  Created by Andrew Johnson on 23/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol ShowUsersBusinessLogic {
    func findUsers(request: ShowUsers.FindUsers.Request)
}

protocol ShowUsersDataStore {
}

class ShowUsersInteractor: ShowUsersBusinessLogic, ShowUsersDataStore {
    // MARK: - Properties
    var presenter: ShowUsersPresentationLogic?
    var worker: ShowUsersWorker = ShowUsersWorker()
  
    // MARK: - Use Cases
    func findUsers(request: ShowUsers.FindUsers.Request) {
        worker.findUsers(users: usersFound)
    }
    
    // MARK: - Use case callbacks
    func usersFound(users: [TempUser]) {
        let response = ShowUsers.FindUsers.Response(users: users)
        presenter?.presentFoundUsers(response: response)
    }
}
