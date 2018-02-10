//
//  Pass business logic outcomes to the View Controller
//
//  Created by Andrew Johnson on 08/02/2018.
//  Copyright (c) 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol AddParentPresentationLogic {
    func presentAddParentResult(response: AddParent.AddParent.Response)
}

class AddParentPresenter: AddParentPresentationLogic {
    // MARK: - Properties
    weak var viewController: AddParentDisplayLogic?
  
    // MARK: - Use cases
    func presentAddParentResult(response: AddParent.AddParent.Response) {
        let viewModel = AddParent.AddParent.ViewModel()
        viewController?.displayAddParentResult(viewModel: viewModel)
    }
}
