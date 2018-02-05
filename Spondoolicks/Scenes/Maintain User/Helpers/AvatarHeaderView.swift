//
//  Provides a header for the Avatar Collection view
//
//  Created by Andrew Johnson on 28/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit

class AvatarHeaderView: UICollectionReusableView {
    // MARK: - IBOutlets
    @IBOutlet weak var sectionName: UILabel!
    
    // MARK: - Functions
    override func awakeFromNib() {
        sectionName.font = FontHelper.getFontFor(.body, size: FontHelper.MinSize.medium, traitCollection: traitCollection)
        self.layer.cornerRadius = 5.0
    }
    
    func configureHeader(section: Int) {
        sectionName.text = Global.Identifier.Names.AVATAR_HEADING_NAMES[section]
    }
}
