//
//  AddMemberViewModel.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 11/07/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import Foundation
import UIKit

protocol AddMemberViewModelDelegate: class {
    func willPostMember()
    func didPostMember()
    func postMemberDidFail(error: Error)
}

class AddMemberViewModel {
    
    weak var delegate: AddMemberViewModelDelegate?
    let membersEndpoint = "/administrations/%@/members?email=%@"

    // MARK: Public Methods
    
    func post(memberEmail: String, administrationId: String) {
        delegate?.willPostMember()
        
        let encodedEmail = memberEmail.addingPercentEncoding(withAllowedCharacters: .rfc3986Unreserved) ?? ""
        let endpoint = String(format: membersEndpoint, administrationId, encodedEmail)
        
        let _ = APICLient().postEntity(endpoint: endpoint) { (member: User?, error) in
            if error != nil {
                self.delegate?.postMemberDidFail(error: error!)
            } else {
                self.delegate?.didPostMember()
            }
        }
    }
}
