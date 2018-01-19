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
    let horizontalAnchorConstant: CGFloat = 32.0

    // MARK: - IBOutlets
    @IBOutlet weak var optionIcon: UIImageView!
    @IBOutlet weak var optionName: UILabel!
    
    // MARK: - Configuration
    func configureForUsers() {
        optionIcon.image = UIImage(named: Global.AssetInfo.profileIcon)
        optionName.text = "Users"
        configureLayout()
    }
    
    func configureForSettings() {
        optionIcon.image = UIImage(named: Global.AssetInfo.settingsIcon)
        optionName.text = "Settings"
        configureLayout()
    }
    
    func configureLayout() {
        configureOptionName()
        if regularConstraints.count == 0 {
            setupLayoutConstraints()
            updateLayoutConstraints()
        }
    }
    
    func configureOptionName() {
        if let font = UIFont(name: "OpenSans-Bold", size: 36) {
            if traitCollection.userInterfaceIdiom == .phone {
                optionName.font = UIFontMetrics.default.scaledFont(for: font, maximumPointSize: Global.FontInfo.maxPointSizeForIPhone) // Any bigger on an iPhone and it runs off the screen edges.
            } else {
                optionName.font = UIFontMetrics.default.scaledFont(for: font)
            }
        }
        optionIcon.translatesAutoresizingMaskIntoConstraints = false
        optionName.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupLayoutConstraints() {
        
        regularConstraints = [

            optionIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalAnchorConstant),
            optionIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            optionIcon.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: verticalAnchorConstant),
            optionIcon.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -verticalAnchorConstant),

            optionName.leadingAnchor.constraint(equalTo: optionIcon.trailingAnchor, constant: horizontalAnchorConstant),
            optionName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
       ]

        largeTextConstraints = [

            optionIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            optionIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalAnchorConstant),

            optionName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            optionName.topAnchor.constraint(equalTo: optionIcon.bottomAnchor, constant: verticalAnchorConstant),
            optionName.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -verticalAnchorConstant)
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
