//
//  MainNavigationViewController.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 24/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit

class MainNavigationViewController: UINavigationController {
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Private Methods
    
    func setupUI() {
        navigationBar.barTintColor = .primary
        navigationBar.tintColor = .white
        
        let textAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.header
        ]
        navigationBar.titleTextAttributes = textAttributes
    }
}
