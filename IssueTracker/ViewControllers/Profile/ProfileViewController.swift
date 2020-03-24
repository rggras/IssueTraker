//
//  ProfileViewController.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 05/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailValueLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    
    let viewModel = ProfileViewModel()
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.getUser()
        setupUI()
    }
    
    // MARK: Actions
    
    @IBAction private func didPressSave(_ sender: UIBarButtonItem) {
        updateUser()
    }
    
    @IBAction private func didPressLogout(_ sender: UIButton) {
        AppDelegate.shared.rootViewController.switchToLogin()
    }
    
    // MARK: Private Methods
    
    func setupUI() {
        navigationItem.title = "Settings"

        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        
        emailLabel.font = .smallText
        emailLabel.textColor = .primary
        emailValueLabel.font = .title
        emailValueLabel.textColor = .text
        
        nameLabel.font = .smallText
        nameLabel.textColor = .primary
        nameTextField.font = .title
        nameTextField.textColor = .text
        
        phoneLabel.font = .smallText
        phoneLabel.textColor = .primary
        phoneTextField.font = .title
        phoneTextField.textColor = .text
    }
    
    private func updateUser() {
        let request = User()
        request.phone = phoneTextField.text
        request.name = nameTextField.text
        
        viewModel.update(request: request)
    }
    
    private func fillForm() {
        if let user = viewModel.user {
            emailValueLabel.text = user.email
            nameTextField.text = user.name
            phoneTextField.text = user.phone
            
            if let pictureUrl = user.pictureUrl, let url = URL(string: pictureUrl) {
                profileImage.af_setImage(withURL: url)
            }
        }
    }
}

// MARK: - LoginViewModelDelegate

extension ProfileViewController: ProfileViewModelDelegate {
    
    func willGetUser() {
        // TODO: show loading
    }
    
    func didGetUser() {
        fillForm()
        isEditing = false
    }
    
    func getUserDidFail(error: Error) {
        // TODO: show loading
    }
}

