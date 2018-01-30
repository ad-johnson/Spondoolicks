//
//  Temporary representation of an App user pending set up of Core Data
//  Spondoolicks
//
//  Created by Andrew Johnson on 24/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

struct TempUser: Equatable {
    static var users: [TempUser] = { createTestUsers() }()
    var userId: Int
    var userName: String
    var avatarImage: String
    
    static func == (lhs: TempUser, rhs: TempUser) -> Bool {
        return  lhs.userId == rhs.userId &&
                lhs.userName == rhs.userName &&
                lhs.avatarImage == rhs.avatarImage
    }
    
   static func createTestUsers() -> [TempUser] {
        var tempUsers = [TempUser]()
        tempUsers.append(TempUser(userId: 0, userName: "Andrew", avatarImage: "boy-0"))
        tempUsers.append(TempUser(userId: 1, userName: "David", avatarImage: "boy-1"))
        tempUsers.append(TempUser(userId: 2, userName: "Katherine", avatarImage: "girl-2"))
        tempUsers.append(TempUser(userId: 3, userName: "Richard", avatarImage: "boy-3"))
        tempUsers.append(TempUser(userId: 4, userName: "Rosalind", avatarImage: "girl-4"))
        tempUsers.append(TempUser(userId: 5, userName: "Stan", avatarImage: "boy-5"))
        tempUsers.append(TempUser(userId: 6, userName: "Ferdinando De BigName", avatarImage: "boy-6"))
        return tempUsers
    }
}
