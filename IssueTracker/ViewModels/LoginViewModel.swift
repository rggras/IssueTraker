//
//  LoginViewModel.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 01/07/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate: class {
    func willPostUser()
    func didPostUser()
    func postUserDidFail(error: Error)
}

class LoginViewModel {
    
    weak var delegate: LoginViewModelDelegate?
    let endpoint = "/users"
    var user: User?
    
    // MARK: Public Methods
    
    func post(user: User) {
        delegate?.willPostUser()
        
        let _ = APICLient().postEntity(endpoint: endpoint, parameters: user.toJSON()) { (response: User?, error) in
            if error != nil {
                self.delegate?.postUserDidFail(error: error!)
            } else {                
                self.user = response
                self.delegate?.didPostUser()
            }
        }
    }
}
