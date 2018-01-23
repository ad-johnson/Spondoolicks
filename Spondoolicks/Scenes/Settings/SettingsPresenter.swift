//
//  SettingsPresenter.swift
//
//  Created by Andrew Johnson on 23/01/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol SettingsPresentationLogic {
    func presentSomething(response: Settings.Something.Response)
}

class SettingsPresenter: SettingsPresentationLogic {
    // MARK: - Properties
    weak var viewController: SettingsDisplayLogic?
  
    // MARK: - Use cases
    func presentSomething(response: Settings.Something.Response) {
        let viewModel = Settings.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
