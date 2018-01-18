//
//  Extension functionality for UI Framework classes.
//
//  Created by Andrew Johnson on 18/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit

// MARK: - Orientation support
extension UINavigationController {
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if traitCollection.userInterfaceIdiom == .phone {
            return UIInterfaceOrientationMask.portrait.union(.portraitUpsideDown)
        } else {
            return UIInterfaceOrientationMask.all
        }
    }
}

extension UITabBarController {
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if traitCollection.userInterfaceIdiom == .phone {
            return UIInterfaceOrientationMask.portrait.union(.portraitUpsideDown)
        } else {
            return UIInterfaceOrientationMask.all
        }
    }
}

