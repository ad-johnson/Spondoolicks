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
                var userId: Int
                var userName: String
                var avatarImage: String
                
                static func == (lhs: DisplayedUser, rhs: DisplayedUser) -> Bool {
                    return  lhs.userId == rhs.userId &&
                            lhs.userName == rhs.userName &&
                            lhs.avatarImage == rhs.avatarImage
                }
            }
            var displayedUsers: [DisplayedUser]
        }
    }
    
    enum DeleteUser {
        struct Request {
            var userId: Int
        }
        
        struct Response {
            var error: Error?
        }
        
        struct ViewModel {
            var error: Error?
        }
    }
    
    enum EditUser {
        struct Request {
            var userId: Int
        }
        
        struct Response { }
        struct ViewModel { }
    }
}
