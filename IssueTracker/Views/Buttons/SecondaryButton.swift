//
//  SecondaryButton.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 15/07/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit

class SecondaryButton: UIButton {
    
    // MARK: View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: Private Methods
    
    func setupUI() {
        titleLabel?.font = .title
        setTitleColor(.secondary, for: .normal)
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondary.cgColor
        layer.cornerRadius = 6
    }
}
