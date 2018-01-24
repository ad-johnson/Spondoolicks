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
            struct DisplayedUser {
                var userName: String
                var avatarImage: String
            }
            var displayedUsers: [DisplayedUser]
        }
    }
}
