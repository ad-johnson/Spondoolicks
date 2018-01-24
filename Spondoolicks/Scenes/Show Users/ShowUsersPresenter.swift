//
//  ShowUsersPresenter.swift
//
//  Created by Andrew Johnson on 23/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol ShowUsersPresentationLogic {
    func presentFoundUsers(response: ShowUsers.FindUsers.Response)
}

class ShowUsersPresenter: ShowUsersPresentationLogic {
    // MARK: - Properties
    weak var viewController: ShowUsersDisplayLogic?
  
    // MARK: - Use cases
    func presentFoundUsers(response: ShowUsers.FindUsers.Response) {
        var displayedUsers = [ShowUsers.FindUsers.ViewModel.DisplayedUser]()
        if !response.users.isEmpty {
            for user in response.users {
                displayedUsers.append(ShowUsers.FindUsers.ViewModel.DisplayedUser(userName: user.userName, avatarImage: user.avatarImage))
            }
            
            let viewModel = ShowUsers.FindUsers.ViewModel(displayedUsers: displayedUsers)
            viewController?.displayUsers(viewModel: viewModel)
        }
    }
}
