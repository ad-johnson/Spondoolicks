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
        let imageName = Global.AssetInfo.getAvatarName(indexPath: indexPath)
        if let image = UIImage(named: imageName) {
            avatarImage.image = image
        } else {
            avatarImage.image = UIImage(named: Global.AssetInfo.PROFILE_ICON)
        }
    }
}
