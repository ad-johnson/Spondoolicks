//
//  SPBorderedPicker.swift
//  Spondoolicks
//
//  Created by Andrew Johnson on 09/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit

class SPBorderedPicker: UIPickerView, SPView {
    
    override func awakeFromNib() {
        setViewProperties()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setViewProperties()
    }
}
