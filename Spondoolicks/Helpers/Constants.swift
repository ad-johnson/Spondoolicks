//
//  Defines global constants and helper methods
//
//  Created by Andrew Johnson on 18/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit

enum Global {
    
    struct FontInfo {
        
        // MARK: - Dynamic Type support
        // To support dynamic type and maximise font size that can be used
        // within the app based on the device and orientation.
        static func basePointSize(traitCollection: UITraitCollection, adjustFor: UIFontTextStyle = .body) -> CGFloat {
            var basePointSize: CGFloat = 36.0 // base working size
            
            if traitCollection.horizontalSizeClass == .compact {
                if UIScreen.main.bounds.width < 375 {
                    basePointSize = 32 // For narrow screens
                }
            }
            var adjustAmount: CGFloat = 0.0
            
            switch adjustFor {
            case .title2:
                adjustAmount = -4.0
            default:
                break
            }
            return basePointSize + adjustAmount
        }
        
        static func maxPointSize(traitCollection: UITraitCollection, adjustFor: UIFontTextStyle = .body) -> CGFloat {
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
            
            var adjustAmount: CGFloat = 0.0
            
            switch adjustFor {
            case .title2:
                adjustAmount = 0.0
            default:
                break
            }
            return maxPointSize + adjustAmount
        }
    }
    
    struct AssetInfo {
        static let profileIcon = "Profile icon"
        static let settingsIcon = "Settings icon"
    }
}
