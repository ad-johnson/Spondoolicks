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
            static let HELP_ENTRY_CELL = "HelpEntryCell"
            static let HELP_PANEL_HEADER_CELL = "HelpPanelHeaderCell"
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
    
    struct AssetInfo {
        static let PROFILE_ICON = "Profile icon"
        static let SETTINGS_ICON = "Settings icon"
        static let AVATAR_CREDIT = "Avatars made by Freepik from www.flaticon.com"
        static let AVATAR_IMAGE_NAME = ["girl-", "boy-"]
        static let NUMBER_OF_AVATARS = [27, 23] // Avatar images: Girls, Boys
        
        // MARK: - Avatar helper methods
        static func getAvatarName(indexPath: IndexPath) -> String {
            return getAvatarName(section: indexPath.section, row: indexPath.row)
        }
        
        static func getAvatarName(section: Int, row: Int) -> String {
            return "\(AVATAR_IMAGE_NAME[section])\(row)"
        }
        
        static func getDefaultAvatarImage() -> UIImage {
            // Force unwrap as this is a development time issue if not available.
            return UIImage(named: Global.AssetInfo.PROFILE_ICON)!
        }
        
        static func getAvatar(indexPath: IndexPath) -> UIImage {
            let avatarName = getAvatarName(indexPath: indexPath)
            return getAvatar(named: avatarName)
        }
        
        static func getAvatar(named: String) -> UIImage {
            if let image = UIImage(named: named) {
                return image
            } else {
                return getDefaultAvatarImage()
            }
        }
    }
    
    enum Errors {
        enum UserMaintenanceError: Error {
            case userNotFound
        }
    }
}
