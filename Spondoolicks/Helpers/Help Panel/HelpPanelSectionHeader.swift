//
//  Custom Section Header for Help Panel.
//
//  Created by Andrew Johnson on 05/02/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit

class HelpPanelSectionHeader: UITableViewHeaderFooterView {

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
