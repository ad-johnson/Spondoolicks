//
//  View that will allow for tailoring defaulting to a designed lozenge shape
//
//  Created by Andrew Johnson on 20/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit

@IBDesignable
class LozengeView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 24.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    public var borderColour: UIColor = UIColor.darkGray {
        didSet {
            layer.borderColor = borderColour.cgColor
        }
    }
    
    @IBInspectable
    public var backgroundColour: UIColor = UIColor.clear {
        didSet {
            layer.backgroundColor = backgroundColour.cgColor
        }
    }
    
    // Added this because IBDesignable does not include named colours in
    // the colour picker and selecting one (through the previous options)
    // results in errors in the Storyboard.
    @IBInspectable
    public var useDesignColours: Bool = false {
        didSet {
            if useDesignColours {
                layer.backgroundColor = UIColor(named: "sp Purple")?.cgColor
                layer.borderWidth = 2.0
                layer.borderColor = UIColor(named: "sp Green")?.cgColor
            }
        }
    }
}
