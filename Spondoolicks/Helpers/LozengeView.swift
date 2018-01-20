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
    public var borderColour: UIColor = #colorLiteral(red: 0.5450000167, green: 1, blue: 0.2389999926, alpha: 1) {
        didSet {
            layer.borderColor = borderColour.cgColor
        }
    }
    
    @IBInspectable
    public var backgroundColour: UIColor = #colorLiteral(red: 0.5019999743, green: 0, blue: 0.5799999833, alpha: 1) {
        didSet {
            layer.backgroundColor = backgroundColour.cgColor
        }
    }
}
