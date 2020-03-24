//
//  AttachmentViewController.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 12/07/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit

class AttachmentViewController: UIViewController {
    
    @IBOutlet weak var attachmentImage: UIImageView!
    
    var attachmentURL: String?
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Attachments"
        if let attachmentURL = attachmentURL, let url = URL(string: attachmentURL) {
            attachmentImage.af_setImage(withURL: url)
        }
    }
}
