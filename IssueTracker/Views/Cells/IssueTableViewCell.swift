//
//  IssueTableViewCell.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 05/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit

class IssueTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var profileImage: UIImageView!
    
    // MARK: View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: Private Methods
    
    func setupUI() {
        nameLabel.font = .title
        nameLabel.textColor = .text
        
        statusLabel.font = .description
        statusLabel.textColor = .primary
        
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
    }
    
    // MARK: Public Methods
    
    func configure(forIssue issue: Issue) {
        nameLabel.text = "[\(issue.id ?? "")] \(issue.name ?? "")"
        statusLabel.text = issue.status
    }
}
