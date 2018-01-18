//
//  HomePresenter.swift
//
//  Created by Andrew Johnson on 18/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    func presentSomething(response: Home.Something.Response)
}

class HomePresenter: HomePresentationLogic {
    // MARK: - Properties
    weak var viewController: HomeDisplayLogic?
  
    // MARK: - Use cases
    func presentSomething(response: Home.Something.Response) {
        let viewModel = Home.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
