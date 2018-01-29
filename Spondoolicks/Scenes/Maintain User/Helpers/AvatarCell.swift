//
//  Represents an Avatar in the maintain user view
//
//  Created by Andrew Johnson on 27/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var avatarImage: UIImageView!
    
    // MARK: - Functions
    override func awakeFromNib() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureCell(indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        let imageName = "\(Global.AssetInfo.AVATAR_IMAGE_NAME[section])\(row)"
        
        if let image = UIImage(named: imageName) {
            avatarImage.image = image
        } else {
            avatarImage.image = UIImage(named: Global.AssetInfo.PROFILE_ICON)
        }
    }
}
