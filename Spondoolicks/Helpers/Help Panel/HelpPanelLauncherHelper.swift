//
//  Provides a default implementation to display the Help Panel.
//
//  Created by Andrew Johnson on 03/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import Foundation
import UIKit

protocol HelpPanelLauncherHelper: AnyObject {
    func showHelpPanel()
}

extension HelpPanelLauncherHelper where Self: HelpPanelDataSource & UIViewController {
    
    func showHelpPanel() {
        let helpPanel = HelpPanelViewController()
        helpPanel.modalPresentationStyle = .custom
        helpPanel.dataSource = self
        present(helpPanel, animated: true, completion: nil)
    }
}
