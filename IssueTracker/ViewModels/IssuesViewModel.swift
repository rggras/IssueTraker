//
//  IssuesViewModel.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 05/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import Foundation

struct IssueSectionType: OptionSet {
    let rawValue: Int
    
    static let pending = IssueSectionType(rawValue: 0)
    static let onGoing = IssueSectionType(rawValue: 1)
    static let done = IssueSectionType(rawValue: 2)
    static let rejected = IssueSectionType(rawValue: 3)
}

protocol IssuesViewModelDelegate: class {
    func willGetIssues()
    func didGetIssues()
    func getIssuesDidFail(error: Error)
}

class IssuesViewModel {
    
    weak var delegate: IssuesViewModelDelegate?
    var issuesResponse: IssuesResponse?
    let issuesEndpoint = "/administrations/%@/issues"
    let sections: [IssueSectionType] = [.pending, .onGoing, .done, .rejected]
    
    // MARK: Public Methods
    
    func getIssues(administrationId: String) {
        delegate?.willGetIssues()
        
        let endpoint = String(format: issuesEndpoint, administrationId)
        
        let _ = APICLient().getEntity(endpoint: endpoint) { (response: IssuesResponse?, error) in
            if error != nil {
                self.delegate?.getIssuesDidFail(error: error!)
            } else {
                self.issuesResponse = response!
                self.delegate?.didGetIssues()
            }
        }
    }
    
    func issues(forType type: IssueSectionType) -> [Issue] {
        switch type {
            case .pending:
                return issuesResponse?.pendingIssues ?? []
            case .onGoing:
                return issuesResponse?.onGoingIssues ?? []
            case .done:
                return issuesResponse?.doneIssues ?? []
            case .rejected:
                return issuesResponse?.rejectedIssues ?? []
            default:
                return []
            }
    }
    
    func title(forType type: IssueSectionType) -> String {
        switch type {
            case .pending:
                return "Pending"
            case .onGoing:
                return "On Going"
            case .done:
                return "Done"
            case .rejected:
                return "Rejected"
            default:
                return ""
            }
    }
}
