//
//  HelpPanelHeaderViewCell.swift
//  Spondoolicks
//
//  Created by Andrew Johnson on 31/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit

class HelpPanelHeaderCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var subheading: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subheading.font = FontHelper.getFontFor(.subheadline, traitCollection: traitCollection)
    }

    func configureCell(subheading: String) {
        self.subheading.text = subheading
    }
}
