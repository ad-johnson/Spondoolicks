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
            var users: [User]
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
    
    enum DeleteUser {
        struct Request {
            var userName: String
        }
        
        struct Response {
            var error: Error?
        }
        
        struct ViewModel {
            var error: Error?
        }
    }
    // TODO: Do we need this??
//    enum EditUser {
//        struct Request {
//            var userId: Int
//        } s
//
//        struct Response { }
//        struct ViewModel { }
//    }
}
