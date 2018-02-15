//
//  Interacts with persistent storage to handle data requests for Maintain User
//  use cases.
//
//  Created by Andrew Johnson on 27/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

class MaintainUserWorker {
    // Properties
    lazy var coreDataManager = CoreDataManager.instance
    typealias MaintainUserCallback = (Error?) -> ()

    // MARK: - Functions
    func addUser(name: String, avatarImage: String, completion: @escaping (User) -> () ) {
        DispatchQueue.main.async {
            self.coreDataManager.perform(identifier: "AddUser") {
                let user = User.insert(name: name, avatarImage: avatarImage)
                completion(user)
            }
        }
    }
    
    // Just need to force a context save.
    func changeUser(_ user: User, completion: @escaping (Bool) -> () ) {
        DispatchQueue.main.async {
            self.coreDataManager.perform(identifier: "ChangeUser") {
                completion(true)
            }
        }
    }
}
