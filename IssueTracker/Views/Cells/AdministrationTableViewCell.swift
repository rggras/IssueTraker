//
//  AdministrationTableViewCell.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 21/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit
import AlamofireImage

class AdministrationTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var adminLabel: UILabel!
    @IBOutlet var administrationImage: UIImageView!
    
    // MARK: View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: Private Methods
    
    func setupUI() {
        nameLabel.font = .title
        nameLabel.textColor = .text
        
        adminLabel.font = .smallText
        adminLabel.textColor = .primary
        
        administrationImage.layer.cornerRadius = administrationImage.frame.height / 2
    }
    
    // MARK: Public Methods
    
    func configure(forAdministration administration: Administration) {
        nameLabel.text = administration.name
        adminLabel.isHidden = administration.role != .admin
        
        if let pictureUrl = administration.pictureUrl, let url = URL(string: pictureUrl) {
            administrationImage.af_setImage(withURL: url)
        } else {
            administrationImage.image = UIImage(named: "AdministrationPlaceHolder")
        }
    }
}
