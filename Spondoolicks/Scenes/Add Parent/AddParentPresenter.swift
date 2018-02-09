//
//  AddParentPresenter.swift
//
//  Created by Andrew Johnson on 08/02/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol AddParentPresentationLogic {
    func presentSomething(response: AddParent.Something.Response)
}

class AddParentPresenter: AddParentPresentationLogic {
    // MARK: - Properties
    weak var viewController: AddParentDisplayLogic?
  
    // MARK: - Use cases
    func presentSomething(response: AddParent.Something.Response) {
        let viewModel = AddParent.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
