//
//  MembersViewController.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 11/07/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit

class MembersViewController: UITableViewController {
    
    let viewModel = MembersViewModel()
    let userDefaultsManager = UserDefaultsManager(userDefaults: .standard)
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getMembers(administrationId: userDefaultsManager.currentAdministrationId ?? "")
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.members.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberTableViewCell") as! MemberTableViewCell
        cell.configure(forMember: viewModel.members[indexPath.row])
        return cell
    }
}

// MARK: - DashboardViewModelDelegate

extension MembersViewController: MembersViewModelDelegate {
    
    func willGetMembers() {
        // TODO: show loading
    }
    
    func didGetMembers() {
        tableView.reloadData()
    }
    
    func getMembersDidFail(error: Error) {
        // TODO: show loading
    }
}
