//
//  Defines global constants and helper methods
//
//  Created by Andrew Johnson on 18/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit

enum Global {
    
    struct Segue {
        static let SHOW_USERS = "ShowUsers"
        static let SHOW_SETTINGS = "ShowSettings"
    }
    
    struct Identifiers {
        static let MAIN_STORYBOARD = "Main"
        static let OPTION_CELL = "OptionCell"
        static let HOME_VC = "HomeVC"
        static let SHOW_USERS_VC = "ShowUsersVC"
        static let SETTINGS_VC = "SettingsVC"
    }
    
    struct FontInfo {
        static let HEADING_FONT = "OpenSans-SemiBold"
        static let ATTENTION_FONT = "OpenSans-Bold"
        static let BODY_FONT = "OpenSans-Regular"
        
        // MARK: - Dynamic Type support
        // To support dynamic type and maximise font size that can be used
        // within the app based on the device and orientation.
        static func basePointSize(traitCollection: UITraitCollection) -> CGFloat {
            var basePointSize: CGFloat = 36.0 // base working size
            
            if traitCollection.horizontalSizeClass == .compact {
                if UIScreen.main.bounds.width < 375 {
                    basePointSize = 32 // For narrow screens
                }
            }
            return basePointSize
        }
        
        static func maxPointSize(traitCollection: UITraitCollection) -> CGFloat {
            var maxPointSize: CGFloat = 44.0 // base working size

            if traitCollection.horizontalSizeClass == .compact {
                if UIScreen.main.bounds.width < 375 {
                    maxPointSize = 36 // For narrow screens
                }
            }
            
            if traitCollection.preferredContentSizeCategory.isAccessibilityCategory {
                if UIScreen.main.bounds.width < 400 {
                    maxPointSize = 58.0 // for narrow screens
                } else {
                    maxPointSize = 62.0 // larger screens
                }
            }
            return maxPointSize
        }
    }
    
    struct AssetInfo {
        static let PROFILE_ICON = "Profile icon"
        static let SETTINGS_ICON = "Settings icon"
    }
}
