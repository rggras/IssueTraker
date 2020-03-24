//
//  AddIssueViewModel.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 08/07/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import Foundation
import UIKit

protocol AddIssueViewModelDelegate: class {
    func willPostIssue()
    func didPostIssue()
    func postIssueDidFail(error: Error)
    func willUpdateIssue()
    func didUpdateIssue()
    func updateIssueDidFail(error: Error)
    func willGetPriorities()
    func didGetPriorities()
    func getPrioritiesDidFail(error: Error)
    func willGetStatuses()
    func didGetStatuses()
    func getStatusesDidFail(error: Error)
}

class AddIssueViewModel {
    
    weak var delegate: AddIssueViewModelDelegate?
    let postEndpoint = "/administrations/%@/issues"
    let updateEndpoint = "/issues"
    let prioritiesEndpoint = "/issues/priorities"
    let statusesEndpoint = "/issues/status"
    var priorities: [Priority] = []
    var statuses: [Status] = []
    
    // MARK: Public Methods
    
    func post(request: IssueRequest, administrationId: String, attachment: UIImage?) {
        delegate?.willPostIssue()
        
        let endpoint = String(format: postEndpoint, administrationId)
        
        let _ = APICLient().postMultipartEntity(endpoint: endpoint, parameters: request.toJSON(), image: attachment, imageKey: "issuePic") { (issue: Issue?, error) in
            if error != nil {
                self.delegate?.postIssueDidFail(error: error!)
            } else {
                self.delegate?.didPostIssue()
            }
        }
    }
    
    func update(request: IssueRequest, issueId: String, attachment: UIImage?) {
        delegate?.willUpdateIssue()
        
        let endpoint = updateEndpoint + "/" + issueId
        
        let _ = APICLient().putMultipartEntity(endpoint: endpoint, parameters: request.toJSON(), image: attachment, imageKey: "issuePic") { (issue: Issue?, error) in
            if error != nil {
                self.delegate?.updateIssueDidFail(error: error!)
            } else {
                self.delegate?.didUpdateIssue()
            }
        }
    }
    
    func getPriorities() {
        delegate?.willGetPriorities()

        let _ = APICLient().getEntities(endpoint: prioritiesEndpoint) { (priorities: [Priority]?, error) in
            if error != nil {
                self.delegate?.getPrioritiesDidFail(error: error!)
            } else {
                self.priorities = priorities!
                self.delegate?.didGetPriorities()
            }
        }
    }
    
    func getStatuses() {
        delegate?.willGetStatuses()
        
        let _ = APICLient().getEntities(endpoint: statusesEndpoint) { (statuses: [Status]?, error) in
            if error != nil {
                self.delegate?.getStatusesDidFail(error: error!)
            } else {
                self.statuses = statuses!
                self.delegate?.didGetStatuses()
            }
        }
    }
}
