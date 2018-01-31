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
        static let MAINTAIN_USER = "ShowMaintainUser"
    }
    
    struct Identifier {
        struct Storyboard {
            static let MAIN = "Main"
        }
        struct Cell {
            static let OPTION_CELL = "OptionCell"
            static let USER_CELL = "UserCell"
            static let AVATAR_CELL = "AvatarCell"
            static let AVATAR_HEADER = "AvatarHeader"
        }
        struct ViewController {
            static let HOME_VC = "HomeVC"
            static let SHOW_USERS_VC = "ShowUsersVC"
            static let SETTINGS_VC = "SettingsVC"
            static let MAINTAIN_USER_VC = "MaintainUserVC"
        }
        struct Names {
            static let AVATAR_HEADING_NAMES = ["Girls", "Boys"]
        }
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
        static let AVATAR_CREDIT = "Avatars made by Freepik from www.flaticon.com"
        static let AVATAR_IMAGE_NAME = ["girl-", "boy-"]
        static let NUMBER_OF_AVATARS = [27, 23] // Avatar images: Girls, Boys
        
        static func getAvatarName(indexPath: IndexPath) -> String {
            return getAvatarName(section: indexPath.section, row: indexPath.row)
        }
        static func getAvatarName(section: Int, row: Int) -> String {
            return "\(AVATAR_IMAGE_NAME[section])\(row)"
        }
    }
    
    enum Errors {
        enum UserMaintenanceError: Error {
            case userNotFound
        }
    }
}
