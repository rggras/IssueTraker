//
//  WalkthroughSlideView.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 05/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit

class WalkthroughSlideView: UIView {
    
    @IBOutlet weak var slideImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    // MARK: View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: Private Methods
    
    private func setupUI() {
        titleLabel.textColor = .white
        titleLabel.font = .hero
        
        subtitleLabel.textColor = .white
        subtitleLabel.font = .title
    }
    
    // MARK: Public Methods
    
    func setupFor(slide: Walkthrough) {
        slideImage.image = UIImage(named: slide.imageName ?? "")
        titleLabel.text = slide.title
        subtitleLabel.text = slide.subtitle
    }
}

