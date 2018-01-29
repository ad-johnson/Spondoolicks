//
//  Models for Maintain User
//
//  Created by Andrew Johnson on 27/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

enum MaintainUser {
    // MARK: - Use cases
    enum GetUser {
        struct Request { }
        
        struct Response {
            var user: TempUser?
        }
        
        struct ViewModel {
            struct DisplayedUser: Equatable {
                var userId: Int
                var userName: String
                var avatarImage: String
                
                static func == (lhs: DisplayedUser, rhs: DisplayedUser) -> Bool {
                    return  lhs.userId == rhs.userId &&
                        lhs.userName == rhs.userName &&
                        lhs.avatarImage == rhs.avatarImage
                }
            }
            var displayedUser: DisplayedUser
        }
    }
}
