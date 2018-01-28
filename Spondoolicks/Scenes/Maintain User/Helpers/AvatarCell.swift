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
        var imageName = Global.AssetInfo.PROFILE_ICON
        
        if section == 0 {
            imageName = "girl-\(row)"
        } else {
            imageName = "boy-\(row)"
        }
        
        if let image = UIImage(named: imageName) {
            avatarImage.image = image
        }
    }
}
