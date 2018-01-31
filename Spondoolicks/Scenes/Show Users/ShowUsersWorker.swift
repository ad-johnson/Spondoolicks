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
    typealias UserCallback = ([TempUser]) -> ()
    typealias ErrorCallback = ([TempUser], Error?) -> ()
    
    var usersCallback: UserCallback?
    
    // MARK: - Functions
    // All functions are placeholders for outline functionality prior to
    // implementing Core Data services.  These will be re-factored to use that
    // service when ready.
    func findUsers(callback: @escaping UserCallback) {
        usersCallback = callback
        DispatchQueue.main.async {
            self.usersCallback?(TempUser.users)
        }
    }
    
    func deleteUser(userId: Int, callback: @escaping ErrorCallback) {
        DispatchQueue.main.async {
            var found = false
            for index in 0..<TempUser.users.count {
                if TempUser.users[index].userId == userId {
                    TempUser.users.remove(at: index)
                    found = true
                    break
                }
            }
            if found {
                callback(TempUser.users, nil)
            } else {
                callback(TempUser.users, Global.Errors.UserMaintenanceError.userNotFound)
            }
        }
    }
}
