//
//  AddMemberViewController.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 11/07/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit

class AddMemberViewController: UITableViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextfield: UITextField!
    
    let userDefaultsManager = UserDefaultsManager(userDefaults: .standard)
    let viewModel = AddMemberViewModel()
    var administrationId: String?
    var imagePicker: ImagePicker!
    var selectedAvatar: UIImage?
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        tableView.tableFooterView = UIView()
        setupUI()
    }
    
    // MARK: Actions
    
    @IBAction func didPressSave(_ sender: UIBarButtonItem) {
        addMember()
    }

    // MARK: Private Methods
    
    private func setupUI() {
        emailLabel.font = .smallText
        emailLabel.textColor = .primary
        emailTextfield.font = .title
        emailTextfield.textColor = .text
    }
    
    private func addMember() {
        viewModel.post(memberEmail: emailTextfield.text ?? "", administrationId: userDefaultsManager.currentAdministrationId ?? "")
    }
}

// MARK: - AddAdministrationViewModel

extension AddMemberViewController: AddMemberViewModelDelegate {
    
    func willPostMember() {
        // TODO: show loading
    }
    
    func didPostMember() {
        navigationController?.popViewController(animated: true)
    }
    
    func postMemberDidFail(error: Error) {
        // TODO: show loading and error
    }
}
