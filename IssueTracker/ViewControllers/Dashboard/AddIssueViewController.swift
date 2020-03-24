//
//  AddIssueViewController.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 08/07/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit

class AddIssueViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var priorityTextField: UITextField!
    @IBOutlet weak var priorityPickerView: UIPickerView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var statusPickerView: UIPickerView!
    @IBOutlet weak var attachButton: UIButton!
    @IBOutlet weak var attachImage: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    let viewModel = AddIssueViewModel()
    var issue: Issue?
    var imagePicker: ImagePicker!
    var selectedAttachment: UIImage?
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.getPriorities()
        viewModel.getStatuses()
        
        imagePicker = ImagePicker(presentationController: self, delegate: self)
        tableView.tableFooterView = UIView()
        setupUI()
        saveButton.target = self

        if issue != nil {
            fillForm()
            saveButton.action = #selector(updateIssue)
        } else {
            saveButton.action = #selector(addIssue)
        }
    }
    
    // MARK: Actions

    @IBAction func didPressAttach(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func didPressAttachImage(_ sender: UIButton) {
        if let pictureUrl = issue?.pictureUrl {
            let sb = UIStoryboard(name: "Attachment", bundle: .main)
            let attachmentVC = sb.instantiateInitialViewController() as! AttachmentViewController
            attachmentVC.attachmentURL = pictureUrl
            navigationController?.pushViewController(attachmentVC, animated: true)
        }
    }
    
    // MARK: Private Methods
    
    private func setupUI() {
        title = "New Issue"
        
        nameLabel.font = .smallText
        nameLabel.textColor = .primary
        nameTextField.font = .title
        nameTextField.textColor = .text
        
        descriptionLabel.font = .smallText
        descriptionLabel.textColor = .primary
        descriptionTextView.font = .title
        descriptionTextView.textColor = .text
        
        priorityLabel.font = .smallText
        priorityLabel.textColor = .primary
        priorityTextField.font = .title
        priorityTextField.textColor = .text
        priorityTextField.inputView = priorityPickerView
        
        statusLabel.font = .smallText
        statusLabel.textColor = .primary
        statusTextField.font = .title
        statusTextField.textColor = .text
        statusTextField.inputView = statusPickerView
        
        attachButton.titleLabel?.font = .title
        attachButton.setTitleColor(.primary, for: .normal)
        attachImage.layer.cornerRadius = attachImage.frame.height / 2
    }
    
    private func fillForm() {
        if let issue = issue {
            title = "[\(issue.id ?? "")]"
            nameTextField.text = issue.name
            descriptionTextView.text = issue.description
            priorityTextField.text = issue.priority
            statusTextField.text = issue.status
            
            if let pictureUrl = issue.pictureUrl, let url = URL(string: pictureUrl) {
                attachImage.af_setImage(withURL: url)
            }
        }
    }
    
    @objc private func addIssue() {
        let userDefaultsManager = UserDefaultsManager(userDefaults: .standard)
        viewModel.post(request: getRequest(), administrationId: userDefaultsManager.currentAdministrationId ?? "", attachment: selectedAttachment)
    }
    
    @objc private func updateIssue() {
        viewModel.update(request: getRequest(), issueId: issue?.id ?? "", attachment: selectedAttachment)
    }
    
    private func getRequest() -> IssueRequest {
        let request = IssueRequest()
        request.name = nameTextField.text
        request.description = descriptionTextView.text
        request.priorityId = viewModel.priorities[priorityPickerView.selectedRow(inComponent: 0)].id
        request.statusId = viewModel.statuses[statusPickerView.selectedRow(inComponent: 0)].id
        return request
    }
}

// MARK: - AddIssueViewModel

extension AddIssueViewController: AddIssueViewModelDelegate {

    func willPostIssue() {
        // TODO: show loading
    }
    
    func didPostIssue() {
        navigationController?.popViewController(animated: true)
    }
    
    func postIssueDidFail(error: Error) {
        // TODO: show loading and error
    }
    
    func willUpdateIssue() {
        // TODO: show loading
    }
    
    func didUpdateIssue() {
        navigationController?.popViewController(animated: true)
    }
    
    func updateIssueDidFail(error: Error) {
        // TODO: show loading
    }
    
    func willGetPriorities() {
        // TODO: show loading
    }
    
    func didGetPriorities() {
        priorityPickerView.reloadComponent(0)
    }
    
    func getPrioritiesDidFail(error: Error) {
        // TODO: show loading
    }
    
    func willGetStatuses() {
        // TODO: show loading
    }
    
    func didGetStatuses() {
        statusPickerView.reloadComponent(0)
    }
    
    func getStatusesDidFail(error: Error) {
        // TODO: show loading
    }
}

// MARK: - ImagePickerDelegate

extension AddIssueViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        selectedAttachment = image
        attachImage.image = image
    }
}

// MARK: - UIPickerViewDelegate

extension AddIssueViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == priorityPickerView {
            priorityTextField.text = viewModel.priorities[row].name
        } else {
            statusTextField.text = viewModel.statuses[row].name
        }
    }
}

// MARK: - UIPickerViewDataSource

extension AddIssueViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == priorityPickerView {
            return viewModel.priorities.count
        } else {
            return viewModel.statuses.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == priorityPickerView {
            return viewModel.priorities[row].name
        } else {
            return viewModel.statuses[row].name
        }
    }
}
