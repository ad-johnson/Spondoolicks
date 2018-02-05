//
//  UIView with green border and rounded corners
//
//  Created by Andrew Johnson on 27/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit
@IBDesignable

class SPBorderedView: UIView, SPView {

    override func awakeFromNib() {
        setViewProperties()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setViewProperties()
    }    
}
