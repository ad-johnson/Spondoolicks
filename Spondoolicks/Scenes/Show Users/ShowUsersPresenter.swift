//
//  ShowUsersPresenter.swift
//
//  Created by Andrew Johnson on 23/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol ShowUsersPresentationLogic {
    func presentSomething(response: ShowUsers.Something.Response)
}

class ShowUsersPresenter: ShowUsersPresentationLogic {
    // MARK: - Properties
    weak var viewController: ShowUsersDisplayLogic?
  
    // MARK: - Use cases
    func presentSomething(response: ShowUsers.Something.Response) {
        let viewModel = ShowUsers.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
