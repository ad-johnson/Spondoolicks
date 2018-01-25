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
    var usersCallback: userCallback?
    
    // MARK: - Functions
    func findUsers(users: @escaping userCallback) {
        usersCallback = users
        DispatchQueue.main.async {
            let tempUsers = self.createTestUsers()
            self.usersCallback?(tempUsers)
        }
    }
    
    func createTestUsers() -> [TempUser] {
        var tempUsers = [TempUser]()
        tempUsers.append(TempUser(userName: "Andrew", avatarImage: "0"))
        tempUsers.append(TempUser(userName: "David", avatarImage: "1"))
        tempUsers.append(TempUser(userName: "Katherine", avatarImage: "2"))
        tempUsers.append(TempUser(userName: "Richard", avatarImage: "3"))
        tempUsers.append(TempUser(userName: "Rosalind", avatarImage: "4"))
        tempUsers.append(TempUser(userName: "Stan", avatarImage: "5"))
        tempUsers.append(TempUser(userName: "Ferdinando De BigName", avatarImage: "6"))
        return tempUsers
    }
}
