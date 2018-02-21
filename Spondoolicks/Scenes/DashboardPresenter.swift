//
//  DashboardPresenter.swift
//
//  Created by Andrew Johnson on 21/02/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol DashboardPresentationLogic {
    func presentSomething(response: Dashboard.Something.Response)
}

class DashboardPresenter: DashboardPresentationLogic {
    // MARK: - Properties
    weak var viewController: DashboardDisplayLogic?
  
    // MARK: - Use cases
    func presentSomething(response: Dashboard.Something.Response) {
        let viewModel = Dashboard.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
