//
//  Helper methods for establishing dynamic fonts for the UI.
//
//  Created by Andrew Johnson on 04/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit

struct FontHelper {
    
    static let fontFamily = "OpenSans"
    
    enum TextStyle: String {
        case regular = "Regular"
        case bold = "Bold"
        case semibold = "SemiBold"
    }
    
    enum MinSize: CGFloat {
        case small = 16.0
        case medium = 20.0
        case large = 24.0
        case extraLarge = 36.0
    }
    
    private init() { }

    static func fullFontName(for textStyle: TextStyle) -> String {
        return "\(FontHelper.fontFamily)-\(textStyle.rawValue)"
    }
    
    static func getFontFor(_ textStyle: UIFontTextStyle, size: MinSize, traitCollection: UITraitCollection) -> UIFont {
        var fontName: String!
        
        switch textStyle {
        case .body:
            fontName = fullFontName(for: .regular)
        case .headline:
            fontName = fullFontName(for: .bold)
        case .subheadline:
            fontName = fullFontName(for: .semibold)
        case .title1:
            fontName = fullFontName(for: .semibold)
        case .title2:
            fontName = fullFontName(for: .semibold)
        case .title3:
            fontName = fullFontName(for: .semibold)
        default:
            fontName = fullFontName(for: .regular)
        }
        
        if let font = UIFont(name: fontName, size: size.rawValue) {
            return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font, compatibleWith: traitCollection)
        } else {
            let font = UIFont.systemFont(ofSize: size.rawValue)
            return UIFontMetrics.default.scaledFont(for: font, compatibleWith: traitCollection)
        }
    }
    
    static func getFontFor(_ textStyle: UIFontTextStyle, traitCollection: UITraitCollection) -> UIFont {
        var minSize: MinSize!
        
        switch textStyle {
        case .body:
            minSize = MinSize.small
        case .headline:
            minSize = MinSize.extraLarge
        case .subheadline:
            minSize = MinSize.medium
        case .title1:
            minSize = MinSize.extraLarge
        case .title2:
            minSize = MinSize.large
        case .title3:
            minSize = MinSize.medium
        default:
            minSize = MinSize.small
        }
        
        return getFontFor(textStyle, size: minSize, traitCollection: traitCollection)        
    }
}
