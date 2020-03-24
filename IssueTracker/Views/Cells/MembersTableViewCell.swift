//
//  MemberTableViewCell.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 11/07/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit
import AlamofireImage

class MemberTableViewCell: UITableViewCell {
    
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var avatarImage: UIImageView!
    
    // MARK: View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: Private Methods
    
    func setupUI() {
        emailLabel.font = .title
        emailLabel.textColor = .text
        
        avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
    }
    
    // MARK: Public Methods
    
    func configure(forMember user: User) {
        emailLabel.text = user.email

        if let pictureUrl = user.pictureUrl, let url = URL(string: pictureUrl) {
            avatarImage.af_setImage(withURL: url)
        }
    }
}
