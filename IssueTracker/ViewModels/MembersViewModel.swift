//
//  MembersViewModel.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 11/07/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import Foundation

protocol MembersViewModelDelegate: class {
    func willGetMembers()
    func didGetMembers()
    func getMembersDidFail(error: Error)
}

class MembersViewModel {
    
    weak var delegate: MembersViewModelDelegate?
    let membersEndpoint = "/administrations/%@/members"
    var members: [User] = []
    
    // MARK: Public Methods
    
    func getMembers(administrationId: String) {
        delegate?.willGetMembers()
        
        let endpoint = String(format: membersEndpoint, administrationId)
        
        let _ = APICLient().getEntities(endpoint: endpoint) { (members: [User]?, error) in
            if error != nil {
                self.delegate?.getMembersDidFail(error: error!)
            } else {
                self.members = members!
                self.delegate?.didGetMembers()
            }
        }
    }
}
