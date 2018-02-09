//
//  A view with solid background with more rounded, thicker, borders.
//
//  Created by Andrew Johnson on 05/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit

class SPLozengeBorderedView: UIView, SPView {

    // MARK: - View Handling
    override func awakeFromNib() {
        setViewProperties()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setViewProperties()
    }

    
    // MARK: - Default view values
    func getCornerRadius() -> CGFloat {
        return 24.0
    }
    
    func getBorderWidth() -> CGFloat {
        return 2.0
    }
    
    func getBackgroundColour() -> CGColor {
        if let colour = UIColor(named: Global.Identifier.Colour.DARK_PURPLE) {
            return colour.cgColor
        } else {
            return UIColor.darkGray.cgColor
        }
    }

}
