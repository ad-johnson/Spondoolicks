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
    typealias MaintainUserCallback = (Error?) -> ()

    // MARK: - Functions
    func addUser(user: TempUser, callback: @escaping MaintainUserCallback) {
        DispatchQueue.main.async {
            TempUser.users.append(user)
            callback(nil)
        }
    }
    
    func changeUser(user: TempUser, callback: @escaping MaintainUserCallback) {
        DispatchQueue.main.async {
            if user.userId < TempUser.users.count {
                TempUser.users[user.userId] = user
                callback(nil)
            } else {
                callback(Global.Errors.UserMaintenanceError.userNotFound)
            }
        }
    }
}
