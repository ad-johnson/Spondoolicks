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
        
        if let font = UIFont(name: Global.FontInfo.HEADING_FONT, size: 20) {
            if traitCollection.horizontalSizeClass == .compact {
                subheading.font = UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: font, maximumPointSize: Global.FontInfo.maxPointSize(traitCollection: traitCollection))
            } else {
                subheading.font = UIFontMetrics(forTextStyle: .subheadline).scaledFont(for: font)
            }
        }
    }

    func configureCell(subheading: String) {
        self.subheading.text = subheading
    }
}
