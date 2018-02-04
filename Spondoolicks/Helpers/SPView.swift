//
//  Provides for a common look to UIview components.  Implementors of this
//  Protocol must override awakeFromNib() and, if required, prepareForInterfaceBuilder()
//  to call setViewProperties(): it is not possible in extensions to override
//  functions to provide a default implementation.
//
//  Implementors should provide an alternative setUniqueViewProperties() if
//  additional setup is required.
//
//  Implementors should provide an alternative set of default properties for
//  specific needs.
//
//  Created by Andrew Johnson on 04/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit

protocol SPView: AnyObject {
    
    func setCommonViewProperties()
    func setUniqueViewProperties()
    func setViewProperties()
    func getCornerRadius() -> CGFloat
    func getBorderWidth() -> CGFloat
    func getBorderColour() -> CGColor
    func getBackgroundColour() -> CGColor
}

extension SPView where Self: UIView {
    
    func setViewProperties() {
        setCommonViewProperties()
        setUniqueViewProperties()
    }
    
    func setUniqueViewProperties() {
        // nothing unique by default
    }
    
    func setCommonViewProperties() {
        layer.cornerRadius = getCornerRadius()
        layer.masksToBounds = true
        layer.borderWidth = getBorderWidth()
        layer.borderColor = getBorderColour()
        layer.backgroundColor = getBackgroundColour()
    }
    
    // MARK: - Default view values
    func getCornerRadius() -> CGFloat {
        return 5.0
    }
    
    func getBorderWidth() -> CGFloat {
        return 1.0
    }
    
    func getBorderColour() -> CGColor {
        // Xcode9 storyboard bug: it doesn't respect named colours from the
        // Asset catalogue (ok at runtime though).  For Storyboard purposes
        // using RED colour so the view is visible.
        if let colour = UIColor(named: "sp Green") {
            return colour.cgColor
        } else {
            return UIColor.red.cgColor
        }
    }
    
    func getBackgroundColour() -> CGColor {
        return UIColor.clear.cgColor
    }
}
