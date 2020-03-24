//
//  ProfileViewModel.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 14/07/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import Foundation

protocol ProfileViewModelDelegate: class {
    func willGetUser()
    func didGetUser()
    func getUserDidFail(error: Error)
}

class ProfileViewModel {
    
    weak var delegate: ProfileViewModelDelegate?
    let endpoint = "/users"
    var user: User?
    
    // MARK: Public Methods
    
    func getUser() {
        delegate?.willGetUser()
        
        let _ = APICLient().getEntity(endpoint: endpoint) { (response: User?, error) in
            if error != nil {
                self.delegate?.getUserDidFail(error: error!)
            } else {
                self.user = response
                self.delegate?.didGetUser()
            }
        }
    }
    
    func update(request: User?) {
        delegate?.willGetUser()
        
        let _ = APICLient().putEntity(endpoint: endpoint, parameters: request?.toJSON()) { (response: User?, error) in
            if error != nil {
                self.delegate?.getUserDidFail(error: error!)
            } else {
                self.user = response
                self.delegate?.didGetUser()
            }
        }
    }
}
