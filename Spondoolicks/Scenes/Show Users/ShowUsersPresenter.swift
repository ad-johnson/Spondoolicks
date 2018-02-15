//
//  ShowUsersPresenter.swift
//
//  Created by Andrew Johnson on 23/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol ShowUsersPresentationLogic {
    func presentFoundUsers(response: ShowUsers.FindUsers.Response)
    func presentDeleteUserResult(response: ShowUsers.DeleteUser.Response)
}

class ShowUsersPresenter: ShowUsersPresentationLogic {
    // MARK: - Properties
    weak var viewController: ShowUsersDisplayLogic?
  
    // MARK: - Use cases
    func presentFoundUsers(response: ShowUsers.FindUsers.Response) {
        if !response.users.isEmpty {
            let displayedUsers = response.users.map { ShowUsers.FindUsers.ViewModel.DisplayedUser(userName: $0.name, avatarImage: $0.avatarImage)}
            
            let viewModel = ShowUsers.FindUsers.ViewModel(displayedUsers: displayedUsers)
            viewController?.displayUsers(viewModel: viewModel)
        }
    }
    
    func presentDeleteUserResult(response: ShowUsers.DeleteUser.Response) {
        let viewModel = ShowUsers.DeleteUser.ViewModel(error: response.error)
        viewController?.userDeleted(viewModel: viewModel)
    }
}
