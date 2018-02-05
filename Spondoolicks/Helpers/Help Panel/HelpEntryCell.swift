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
        helpEntry.font = FontHelper.getFontFor(.body, traitCollection: self.traitCollection)
    }
    
    // MARK: - Functions
    func configureCell(entry: String) {
        helpEntry.text = entry
    }
}
