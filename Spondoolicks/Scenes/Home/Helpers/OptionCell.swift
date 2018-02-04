//
//  Cell for options on the Home screen
//
//  Created by Andrew Johnson on 18/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit

class OptionCell: UITableViewCell {

    // MARK: - Properties
    var regularConstraints: [NSLayoutConstraint] = []
    var largeTextConstraints: [NSLayoutConstraint] = []
    let verticalAnchorConstant: CGFloat = 24.0
    let horizontalAnchorConstant: CGFloat = 24.0
    let cellSpacingShortConstant: CGFloat = -8.0

    // MARK: - IBOutlets
    @IBOutlet weak var optionIcon: UIImageView!
    @IBOutlet weak var optionName: UILabel!
    @IBOutlet weak var optionLozenge: UIView!
    @IBOutlet weak var cellSpacingStoryboardConstraint: NSLayoutConstraint!
    
    // MARK: - Configuration
    func configureForUsers() {
        optionIcon.image = Global.AssetInfo.getDefaultAvatarImage()
        optionName.text = "Users"
        configureLayout()
    }
    
    func configureForSettings() {
        optionIcon.image = UIImage(named: Global.AssetInfo.SETTINGS_ICON)
        optionName.text = "Settings"
        configureLayout()
    }
    
    func configureLayout() {
        configureOptionViews()
        if regularConstraints.count == 0 {
            setupLayoutConstraints()
            updateLayoutConstraints()
        }
    }
    
    func configureOptionViews() {
        
        if let font = UIFont(name: Global.FontInfo.ATTENTION_FONT, size: Global.FontInfo.basePointSize(traitCollection: traitCollection)) {
                optionName.font = UIFontMetrics.default.scaledFont(for: font,  maximumPointSize: Global.FontInfo.maxPointSize(traitCollection: traitCollection))
        }

        optionIcon.translatesAutoresizingMaskIntoConstraints = false
        optionName.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupLayoutConstraints() {
        
        // The standard cell spacing constraint doesn't really work for short
        // screens so should be adjusted
        if UIScreen.main.bounds.height < 600 {
            cellSpacingStoryboardConstraint.constant = cellSpacingShortConstant
        }

        regularConstraints = [

            optionIcon.leadingAnchor.constraint(equalTo: optionLozenge.leadingAnchor, constant: horizontalAnchorConstant),
            optionIcon.centerYAnchor.constraint(equalTo: optionLozenge.centerYAnchor),
            optionIcon.topAnchor.constraint(equalTo: optionLozenge.topAnchor, constant: verticalAnchorConstant),
            optionIcon.bottomAnchor.constraint(equalTo: optionLozenge.bottomAnchor, constant: -verticalAnchorConstant),

            optionName.leadingAnchor.constraint(equalTo: optionIcon.trailingAnchor, constant: horizontalAnchorConstant),
            optionName.centerYAnchor.constraint(equalTo: optionLozenge.centerYAnchor)
       ]

        largeTextConstraints = [

            optionIcon.centerXAnchor.constraint(equalTo: optionLozenge.centerXAnchor),
            optionIcon.topAnchor.constraint(equalTo: optionLozenge.topAnchor, constant: verticalAnchorConstant),

            optionName.centerXAnchor.constraint(equalTo: optionLozenge.centerXAnchor),
            optionName.topAnchor.constraint(equalTo: optionIcon.bottomAnchor, constant: verticalAnchorConstant),
            optionName.bottomAnchor.constraint(equalTo: optionLozenge.bottomAnchor, constant: -verticalAnchorConstant)
        ]
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let isAccessibilityCategory = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        if isAccessibilityCategory != previousTraitCollection?.preferredContentSizeCategory.isAccessibilityCategory {
            updateLayoutConstraints()
        }
    }
    
    private func updateLayoutConstraints() {
        if traitCollection.preferredContentSizeCategory.isAccessibilityCategory {
            NSLayoutConstraint.deactivate(regularConstraints)
            NSLayoutConstraint.activate(largeTextConstraints)
        } else {
            NSLayoutConstraint.deactivate(largeTextConstraints)
            NSLayoutConstraint.activate(regularConstraints)
            
        }
    }

}
