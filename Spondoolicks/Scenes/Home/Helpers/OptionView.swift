//
//  Tailor the standard Lozenge Bordered view with a different background colour
//
//  Created by Andrew Johnson on 20/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit

@IBDesignable
class OptionView: SPLozengeBorderedView {
    
   override func getBackgroundColour() -> CGColor {
        if let colour = UIColor(named: Global.Identifier.Colour.PURPLE) {
            return colour.cgColor
        } else {
            return UIColor.purple.cgColor
        }
    }
}
