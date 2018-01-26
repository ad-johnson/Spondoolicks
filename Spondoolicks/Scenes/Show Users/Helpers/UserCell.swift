//
//  UserCellTableViewCell.swift
//  Spondoolicks
//
//  Created by Andrew Johnson on 24/01/2018.
//  Copyright © 2018 Andrew Johnson. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    // MARK: - Properties
    var regularConstraints: [NSLayoutConstraint] = []
    var largeTextConstraints: [NSLayoutConstraint] = []
    let verticalAnchorConstant: CGFloat = 24.0
    let horizontalAnchorConstant: CGFloat = 24.0
    let minimumSpacingConstant: CGFloat = 8.0

    // MARK: - IBOutlets
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var spacer: UIView!
    
    // MARK: - Configuration
    func configureCell(user: ShowUsers.FindUsers.ViewModel.DisplayedUser) {
        userName.text = user.userName
        userAvatar.image = UIImage(named: "girl")

        configureUserViews()
        if regularConstraints.count == 0 {
            setupLayoutConstraints()
            updateLayoutConstraints()
        }
    }

    func configureUserViews() {
        
        if let font = UIFont(name: Global.FontInfo.BODY_FONT, size: Global.FontInfo.basePointSize(traitCollection: traitCollection)) {
            userName.font = UIFontMetrics.default.scaledFont(for: font,  maximumPointSize: Global.FontInfo.maxPointSize(traitCollection: traitCollection))
        }
        
        userAvatar.translatesAutoresizingMaskIntoConstraints = false
        userName.translatesAutoresizingMaskIntoConstraints = false

    }
    
    func setupLayoutConstraints() {
        
        regularConstraints = [
            userAvatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalAnchorConstant),
            userAvatar.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: verticalAnchorConstant),
            userAvatar.bottomAnchor.constraint(lessThanOrEqualTo: spacer.topAnchor, constant: -verticalAnchorConstant),

            userName.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: horizontalAnchorConstant),
            userName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -minimumSpacingConstant),
            userName.centerYAnchor.constraint(equalTo: userAvatar.centerYAnchor),
            userName.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: verticalAnchorConstant),
            userName.bottomAnchor.constraint(lessThanOrEqualTo: spacer.topAnchor, constant: -verticalAnchorConstant)
        ]
        
        let centredNameConstraint = userName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        centredNameConstraint.priority = UILayoutPriority(rawValue: 999)

        largeTextConstraints = [
            userAvatar.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            userAvatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalAnchorConstant),
            
            centredNameConstraint,
            userName.topAnchor.constraint(equalTo: userAvatar.bottomAnchor, constant: verticalAnchorConstant),
            userName.bottomAnchor.constraint(equalTo: spacer.topAnchor, constant: -verticalAnchorConstant),
            userName.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: minimumSpacingConstant),
            userName.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -minimumSpacingConstant)
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
