//
//  InviteTableViewCell.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 15/07/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit
import AlamofireImage

protocol InviteTableViewCellDelegate: class {
    func didAcceptInvite(id: String?)
    func diddeclineInvite(id: String?)
}

class InviteTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var administrationImage: UIImageView!
    @IBOutlet var declineButton: UIImageView!
    
    var invite: Invite?
    weak var delegate: InviteTableViewCellDelegate?
    
    // MARK: View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: Actions
    
    @IBAction func didPressAccept(_ sender: MainButton) {
        if let invite = invite {
            delegate?.didAcceptInvite(id: invite.id)
        }
    }
    
    @IBAction func didPressDecline(_ sender: SecondaryButton) {
        if let invite = invite {
            delegate?.diddeclineInvite(id: invite.id)
        }
    }
    
    // MARK: Private Methods
    
    func setupUI() {
        titleLabel.font = .title
        titleLabel.textColor = .text
        
        administrationImage.layer.cornerRadius = administrationImage.frame.height / 2
    }
    
    // MARK: Public Methods
    
    func configure(forInvite invite: Invite) {
        self.invite = invite
        titleLabel.text = "You have been invited to " + (invite.administrationName ?? "")

        if let pictureUrl = invite.administrationPictureUrl, let url = URL(string: pictureUrl) {
            administrationImage.af_setImage(withURL: url)
        }
    }
}
