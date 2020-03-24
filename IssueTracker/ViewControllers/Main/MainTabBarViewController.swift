//
//  MainTabBarViewController.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 24/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Private Methods
    
    func setupUI() {
        tabBar.tintColor = .secondary
        tabBar.unselectedItemTintColor = .lightGray
    }
}
