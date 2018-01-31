//
//  HelpEntryCell.swift
//  Spondoolicks
//
//  Created by Andrew Johnson on 31/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit

class HelpEntryCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var helpEntry: UILabel!
    
    // MARK: - Initialisers
    override func awakeFromNib() {
        super.awakeFromNib()

        if let font = UIFont(name: Global.FontInfo.BODY_FONT, size: 16) {
            helpEntry.font = UIFontMetrics.default.scaledFont(for: font,  maximumPointSize: Global.FontInfo.maxPointSize(traitCollection: traitCollection))
        }
    }
    
    // MARK: - Functions
    func configureCell(entry: String) {
        helpEntry.text = entry
    }
}
