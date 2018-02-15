//
//  Interacts with persistent storage to handle data requests for Show Users
//  use cases.
//
//  Created by Andrew Johnson on 23/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import Foundation

class ShowUsersWorker {
    // MARK: - Properties
    lazy var coreDataManager = CoreDataManager.instance
    
    // MARK: - Functions
    func findUsers(completion: @escaping ([User]) -> () ) {        
        DispatchQueue.main.async {
            self.coreDataManager.perform(identifier: "FindUsers") {
                let users = User.findUsers()
                completion(users)
            }
        }
    }
    
    func deleteUser(_ user: User, id: Int, completion: @escaping (Bool, Int) ->() ) {
        DispatchQueue.main.async {
            self.coreDataManager.perform(identifier: "DeleteUser") {
                let result = User.delete(user)
                completion(result, id)
            }
        }
    }
}

