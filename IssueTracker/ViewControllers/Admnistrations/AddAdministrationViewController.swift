//
//  AddAdministrationViewController.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 28/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit

class AddAdministrationViewController: UITableViewController {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressTextfield: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityTextfield: UITextField!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryTextfield: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    let viewModel = AddAdministrationViewModel()
    var administrationId: String?
    var imagePicker: ImagePicker!
    var selectedAvatar: UIImage?
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        imagePicker = ImagePicker(presentationController: self, delegate: self)
        setupUI()
        saveButton.target = self
        
        if administrationId != nil {
            getAdministrations()
            saveButton.action = #selector(updateAdministration)
        } else {
            tableView.tableFooterView?.isHidden = true
            saveButton.action = #selector(addAdministration)
        }
    }
    
    // MARK: Actions

    @IBAction func didPressAvatar(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    // MARK: Private Methods
    
    private func setupUI() {
        title = "New Administration"
        
        avatarImage.layer.cornerRadius = avatarImage.frame.height/2
        
        nameLabel.font = .smallText
        nameLabel.textColor = .primary
        nameTextfield.font = .title
        nameTextfield.textColor = .text
        
        addressLabel.font = .smallText
        addressLabel.textColor = .primary
        addressTextfield.font = .title
        addressTextfield.textColor = .text
        
        cityLabel.font = .smallText
        cityLabel.textColor = .primary
        cityTextfield.font = .title
        cityTextfield.textColor = .text
        
        countryLabel.font = .smallText
        countryLabel.textColor = .primary
        countryTextfield.font = .title
        countryTextfield.textColor = .text
    }
    
    @objc private func addAdministration() {
        viewModel.post(administrationRequest: getRequest(), avatarImage: selectedAvatar)
    }
    
    @objc private func updateAdministration() {
        viewModel.update(administrationId: administrationId!, administrationRequest: getRequest(), avatarImage: selectedAvatar)
    }
    
    private func getAdministrations() {
        viewModel.getAdministration(administrationId: administrationId!)
    }
    
    private func getRequest() -> AdministrationRequest {
        let request = AdministrationRequest()
        request.name = nameTextfield.text
        request.address = addressTextfield.text
        request.city = cityTextfield.text
        request.country = countryTextfield.text
        return request
    }
    
    private func fillForm() {
        if let currentAdministration = viewModel.currentAdministration {
            title = currentAdministration.name
            nameTextfield.text = currentAdministration.name
            addressTextfield.text = currentAdministration.address
            cityTextfield.text = currentAdministration.city
            countryTextfield.text = currentAdministration.country
            
            if let pictureUrl = currentAdministration.pictureUrl, let url = URL(string: pictureUrl) {
                avatarImage.af_setImage(withURL: url)
            }
        }
    }
}

// MARK: - AddAdministrationViewModel

extension AddAdministrationViewController: AddAdministrationViewModelDelegate {
    
    func willPostAdministration() {
        // TODO: show loading
    }
    
    func didPostAdministration() {
        navigationController?.popViewController(animated: true)
    }
    
    func postAdministrationDidFail(error: Error) {
        // TODO: show loading and error
    }
    
    func willUpdateAdministration() {
        // TODO: show loading
    }
    
    func didUpdateAdministration() {
        navigationController?.popViewController(animated: true)
    }
    
    func updateAdministrationDidFail(error: Error) {
        // TODO: show loading
    }
    
    func willGetAdministration() {
        // TODO: show loading
    }
    
    func didGetAdministration() {
        fillForm()
    }
    
    func getAdministrationDidFail(error: Error) {
        // TODO: show loading and error
    }
}

// MARK: - ImagePickerDelegate

extension AddAdministrationViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        selectedAvatar = image
        avatarImage.image = image
    }
}
