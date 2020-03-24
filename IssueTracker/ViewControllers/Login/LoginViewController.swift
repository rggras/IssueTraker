//
//  LoginViewController.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 05/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit
import Auth0

class LoginViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var auth0Button: MainButton!
    
    let viewModel = LoginViewModel()
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.delegate = self
    }
    
    // MARK: Actions
    
    @IBAction func didPressAuth0(_ sender: UIButton) {
        pushAuthScreen()
    }
    
    // MARK: Private Methods
    
    private func setupUI() {
        titleLabel.textColor = .secondary
        titleLabel.font = .hero
    }
    
    private func pushAuthScreen() {
        let lockManager = LockManager()
        lockManager.delegate = self
        lockManager.showAuthScreen(presenter: self)
    }
}

// MARK: - LockManagerDelegate

extension LoginViewController: LockManagerDelegate {
    
    func didAuth(credentials: Credentials, profile: Profile) {
        let defaults = UserDefaultsManager(userDefaults: .standard)
        defaults.auth0IdToken = credentials.idToken
        
        let user = User()
        user.auth0Id = profile.id
        user.name = profile.nickname
        user.email = profile.email
        
        viewModel.post(user: user)
    }
}

// MARK: - LoginViewModelDelegate

extension LoginViewController: LoginViewModelDelegate {
    
    func willPostUser() {
        // TODO: show loading
    }
    
    func didPostUser() {
        // TODO: hide loading
        AppDelegate.shared.rootViewController.switchToMain()
    }
    
    func postUserDidFail(error: Error) {
        // TODO: show loading and error
    }
}
