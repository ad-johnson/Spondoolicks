//
//  View that will allow for tailoring defaulting to a designed lozenge shape
//
//  Created by Andrew Johnson on 20/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit

@IBDesignable
class LozengeView: UIView, SPView {
    
    override func awakeFromNib() {
        setViewProperties()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setViewProperties()
    }

    func getCornerRadius() -> CGFloat {
        return 24.0
    }
    
    func getBorderWidth() -> CGFloat {
        return 2.0
    }
    
    func getBackgroundColour() -> CGColor {
        if let colour = UIColor(named: "sp Purple") {
            return colour.cgColor
        } else {
            return UIColor.purple.cgColor
        }
    }
}
