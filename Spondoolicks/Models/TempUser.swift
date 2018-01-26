//
//  Temporary representation of an App user pending set up of Core Data
//  Spondoolicks
//
//  Created by Andrew Johnson on 24/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation

struct TempUser: Equatable {
    var userId: Int
    var userName: String
    var avatarImage: String
    
    static func == (lhs: TempUser, rhs: TempUser) -> Bool {
        return  lhs.userId == rhs.userId &&
                lhs.userName == rhs.userName &&
                lhs.avatarImage == rhs.avatarImage
    }
}
