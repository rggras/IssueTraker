//
//  AdministrationsViewController.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 21/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit

class AdministrationsViewController: UITableViewController {
    
    let viewModel = AdministrationsViewModel()
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Administrations"
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getAdministrations()
    }
    
    // MARK: Private Methods
    
    private func presentIssuesScreen(forAdministration administration: Administration) {
        let userDefaultsManager = UserDefaultsManager(userDefaults: .standard)
        userDefaultsManager.currentAdministrationId = administration.id
        userDefaultsManager.currentAdministrationRole = administration.role
        userDefaultsManager.currentAdministrationName = administration.name
            
        AppDelegate.shared.rootViewController.switchToIssues()
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let type = viewModel.sections[section]
        return viewModel.items(forType: type).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = viewModel.sections[indexPath.section]
        
        switch type {
            case .invites:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InviteTableViewCell") as! InviteTableViewCell
                cell.delegate = self
                
                let invites = viewModel.items(forType: type)
                cell.configure(forInvite: invites[indexPath.row] as! Invite)
                
                return cell
            case .administrations:
                let cell = tableView.dequeueReusableCell(withIdentifier: "AdministrationTableViewCell") as! AdministrationTableViewCell
                let administrations = viewModel.items(forType: type)
                cell.configure(forAdministration: administrations[indexPath.row] as! Administration)
                return cell
            default:
                return UITableViewCell()
        }
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = viewModel.sections[indexPath.section]
        
        switch type {
            case .invites:
                print("invites")
            case .administrations:
                let administrations = viewModel.items(forType: type)
                presentIssuesScreen(forAdministration: administrations[indexPath.row] as! Administration)
            default:
                print("Wrong section type")
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = viewModel.sections[indexPath.section]
        
        switch type {
            case .invites:
                return 100
            case .administrations:
                return 66
            default:
                return 0
        }
    }
}

// MARK: - InviteTableViewCellDelegate

extension AdministrationsViewController: InviteTableViewCellDelegate {
    
    func didAcceptInvite(id: String?) {
        viewModel.acceptInvite(id: id)
    }
    
    func diddeclineInvite(id: String?) {
        viewModel.declineInvite(id: id)
    }
}

// MARK: - AdministrationsViewModelDelegate

extension AdministrationsViewController: AdministrationsViewModelDelegate {
    
    func willGetAdministrations() {
        // TODO: show loading
    }
    
    func didGetAdministrations() {
        tableView.reloadData()
    }
    
    func getAdministrationsDidFail(error: Error) {
        // TODO: show loading and error
    }
    
    func willAcceptInvite() {
        // TODO: show loading
    }
    
    func didAcceptInvite() {
        viewModel.getAdministrations()
    }
    
    func acceptInviteDidFail(error: Error) {
        // TODO: show loading
    }
    
    func willDeleteInvite() {
        // TODO: show loading
    }
    
    func didDeleteInvite() {
        viewModel.getAdministrations()
    }
    
    func deleteInviteDidFail(error: Error) {
        // TODO: show loading
    }
}
