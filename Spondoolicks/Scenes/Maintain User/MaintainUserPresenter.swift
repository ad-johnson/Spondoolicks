//
//  MaintainUserPresenter.swift
//
//  Created by Andrew Johnson on 27/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol MaintainUserPresentationLogic {
    func presentSomething(response: MaintainUser.Something.Response)
}

class MaintainUserPresenter: MaintainUserPresentationLogic {
    // MARK: - Properties
    weak var viewController: MaintainUserDisplayLogic?
  
    // MARK: - Use cases
    func presentSomething(response: MaintainUser.Something.Response) {
        let viewModel = MaintainUser.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
