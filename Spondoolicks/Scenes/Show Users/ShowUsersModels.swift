//
//  ShowUsersModels.swift
//
//  Created by Andrew Johnson on 23/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

enum ShowUsers {
    // MARK: - Use cases
    enum FindUsers {
        struct Request { }
        
        struct Response {
            var users: [TempUser]
        }
        
        struct ViewModel {
            struct DisplayedUser: Equatable {
                var userName: String
                var avatarImage: String
                
                static func == (lhs: DisplayedUser, rhs: DisplayedUser) -> Bool {
                    return  lhs.userName == rhs.userName &&
                            lhs.avatarImage == rhs.avatarImage
                }
            }
            var displayedUsers: [DisplayedUser]
        }
    }
}
