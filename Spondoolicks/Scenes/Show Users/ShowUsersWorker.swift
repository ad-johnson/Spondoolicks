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
    typealias userCallback = ([TempUser]) -> ()
    typealias errorCallback = ([TempUser], Error?) -> ()
    
    lazy var tempUsers: [TempUser] = { createTestUsers() }()
    var usersCallback: userCallback?
    
    enum UserError: Error {
        case userNotFound
    }
    
    // MARK: - Functions
    // All functions are placeholders for outline functionality prior to
    // implementing Core Data services.  These will be re-factored to use that
    // service when ready.
    func findUsers(callback: @escaping userCallback) {
        usersCallback = callback
        DispatchQueue.main.async {
            self.usersCallback?(self.tempUsers)
        }
    }
    
    func deleteUser(userId: Int, callback: @escaping errorCallback) {
        DispatchQueue.main.async {
            var found = false
            for index in 0..<self.tempUsers.count {
                if self.tempUsers[index].userId == userId {
                    self.tempUsers.remove(at: index)
                    found = true
                    break
                }
            }
            if found {
                callback(self.tempUsers, nil)
            } else {
                callback(self.tempUsers, UserError.userNotFound)
            }
        }
    }
    
    // MARK: - Helper functions
    func createTestUsers() -> [TempUser] {
        var tempUsers = [TempUser]()
        tempUsers.append(TempUser(userId: 1, userName: "Andrew", avatarImage: "0"))
        tempUsers.append(TempUser(userId: 2, userName: "David", avatarImage: "1"))
        tempUsers.append(TempUser(userId: 3, userName: "Katherine", avatarImage: "2"))
        tempUsers.append(TempUser(userId: 4, userName: "Richard", avatarImage: "3"))
        tempUsers.append(TempUser(userId: 5, userName: "Rosalind", avatarImage: "4"))
        tempUsers.append(TempUser(userId: 6, userName: "Stan", avatarImage: "5"))
        tempUsers.append(TempUser(userId: 7, userName: "Ferdinando De BigName", avatarImage: "6"))
        return tempUsers
    }
}
