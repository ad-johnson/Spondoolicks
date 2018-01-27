//
//  UITextField with green border and rounded corners
//
//  Created by Andrew Johnson on 27/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit
@IBDesignable

class spBorderedTextField: UITextField {
    
    override func awakeFromNib() {
        setViewProperties()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setViewProperties()
   }
    
    func setViewProperties() {
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
        layer.borderWidth = 1.0
        // Xcode9 storyboard bug: it doesn't respect named colours from the
        // Asset catalogue (ok at runtime though).  For Storyboard purposes
        // using RED colour so the view is visible.
        if let colour = UIColor(named: "sp Green") {
            layer.borderColor = colour.cgColor
        } else {
            layer.borderColor = UIColor.red.cgColor
        }
        layer.backgroundColor = UIColor.clear.cgColor
        
        // Increase the text indent slightly
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextFieldViewMode.always
        
        if let font = UIFont(name: Global.FontInfo.BODY_FONT, size: 20) {
            self.font = UIFontMetrics.default.scaledFont(for: font)
        }
    }
    
}
