//
//  IssuesViewController.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 05/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit

class IssuesViewController: UITableViewController {

    @IBOutlet weak var administrationsButton: UIBarButtonItem!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    let viewModel = IssuesViewModel()
    let userDefaultsManager = UserDefaultsManager(userDefaults: .standard)
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        tableView.tableFooterView = UIView()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getIssues(administrationId: userDefaultsManager.currentAdministrationId ?? "")
    }
    
    // MARK: Actions
    
    @IBAction private func didPressAdministrations(_ sender: UIBarButtonItem) {
        AppDelegate.shared.rootViewController.switchToMain()
    }
    
    @objc private func didPressAdd(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddIssue", sender: sender)
    }
    
    @objc private func didPressSettings(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "AddAdministration", bundle: .main)
        let addAdministrationVC = sb.instantiateInitialViewController() as! AddAdministrationViewController
        addAdministrationVC.administrationId = userDefaultsManager.currentAdministrationId
        navigationController?.pushViewController(addAdministrationVC, animated: true)
    }
    
    // MARK: Private Methods
    
    private func setupUI() {
        title = userDefaultsManager.currentAdministrationName

        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didPressAdd))
        
        if userDefaultsManager.currentAdministrationRole == .admin {
            let settingsButton = UIBarButtonItem(
                image: UIImage(named: "TabBarSettings"),
                style: .plain,
                target: self,
                action: #selector(didPressSettings))
            navigationItem.rightBarButtonItems = [settingsButton, addButton]
        } else {
            navigationItem.rightBarButtonItems = [addButton]
        }
    }
    
    private func presentDetailsScreen(forIssue issue: Issue) {
        let storyboard = UIStoryboard(name: "AddIssue", bundle: Bundle.main)
        let addIssueVC = storyboard.instantiateInitialViewController() as! AddIssueViewController
        addIssueVC.issue = issue
        navigationController?.pushViewController(addIssueVC, animated: true)
    }
    
    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let type = viewModel.sections[section]
        return viewModel.title(forType: type)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.tintColor = .lightPrimary
        header.textLabel?.font = .description
        header.textLabel?.textColor = .text
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let type = viewModel.sections[section]
        return viewModel.issues(forType: type).count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IssueTableViewCell") as! IssueTableViewCell
        
        let type = viewModel.sections[indexPath.section]
        let issues = viewModel.issues(forType: type)
        cell.configure(forIssue: issues[indexPath.row])
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let type = viewModel.sections[indexPath.section]
        let issues = viewModel.issues(forType: type)
        presentDetailsScreen(forIssue: issues[indexPath.row])
    }
}

// MARK: - IssuesViewModelDelegate

extension IssuesViewController: IssuesViewModelDelegate {
    
    func willGetIssues() {
        // TODO: show loading
    }
    
    func didGetIssues() {
        tableView.reloadData()
    }
    
    func getIssuesDidFail(error: Error) {
        // TODO: show loading
    }
}
