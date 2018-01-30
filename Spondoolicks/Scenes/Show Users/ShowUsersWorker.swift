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
    
//    static var tempUsers: [TempUser] = { createTestUsers() }()
    var usersCallback: UserCallback?
    
    enum UserError: Error {
        case userNotFound
    }
    
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
                callback(TempUser.users, UserError.userNotFound)
            }
        }
    }
    
    // MARK: - Helper functions
//    func createTestUsers() -> [TempUser] {
//        var tempUsers = [TempUser]()
//        tempUsers.append(TempUser(userId: 1, userName: "Andrew", avatarImage: "boy-0"))
//        tempUsers.append(TempUser(userId: 2, userName: "David", avatarImage: "boy-1"))
//        tempUsers.append(TempUser(userId: 3, userName: "Katherine", avatarImage: "girl-2"))
//        tempUsers.append(TempUser(userId: 4, userName: "Richard", avatarImage: "boy-3"))
//        tempUsers.append(TempUser(userId: 5, userName: "Rosalind", avatarImage: "girl-4"))
//        tempUsers.append(TempUser(userId: 6, userName: "Stan", avatarImage: "boy-5"))
//        tempUsers.append(TempUser(userId: 7, userName: "Ferdinando De BigName", avatarImage: "boy-6"))
//        return tempUsers
//    }
}
