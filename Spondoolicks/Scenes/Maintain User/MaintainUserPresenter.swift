//
//  MaintainUserPresenter.swift
//
//  Created by Andrew Johnson on 27/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol MaintainUserPresentationLogic {
    func presentUser(response: MaintainUser.GetUser.Response)
}

class MaintainUserPresenter: MaintainUserPresentationLogic {
    // MARK: - Properties
    weak var viewController: MaintainUserDisplayLogic?
  
    // MARK: - Use cases
    func presentUser(response: MaintainUser.GetUser.Response) {
        if let user = response.user { // Editing a user
            let displayedUser = MaintainUser.GetUser.ViewModel.DisplayedUser(userId: user.userId, userName: user.userName, avatarImage: user.avatarImage)
            let viewModel = MaintainUser.GetUser.ViewModel(displayedUser: displayedUser)
            viewController?.displayUser(viewModel: viewModel)
        } else { // Adding a user
            viewController?.displayUser(viewModel: nil)
        }
    }
}
