//
//  MainButton.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 28/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit

class MainButton: UIButton {
    
    // MARK: View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: Private Methods
    
    func setupUI() {
        titleLabel?.font = .title
        setTitleColor(.white, for: .normal)
        backgroundColor = .secondary
        layer.cornerRadius = 6
    }
}
