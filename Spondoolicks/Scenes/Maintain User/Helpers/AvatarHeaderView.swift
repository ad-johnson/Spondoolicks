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
        if let font = UIFont(name: Global.FontInfo.BODY_FONT, size: 20) {
            sectionName.font = UIFontMetrics.default.scaledFont(for: font)
        }
    }
    
    func configureHeader(section: Int) {
        sectionName.text = Global.Identifier.Names.AVATAR_HEADING_NAMES[section]
    }
}
