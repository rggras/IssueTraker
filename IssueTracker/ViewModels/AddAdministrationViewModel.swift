//
//  AddAdministrationViewModel.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 01/07/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import Foundation
import UIKit

protocol AddAdministrationViewModelDelegate: class {
    func willPostAdministration()
    func didPostAdministration()
    func postAdministrationDidFail(error: Error)

    func willUpdateAdministration()
    func didUpdateAdministration()
    func updateAdministrationDidFail(error: Error)
    
    func willGetAdministration()
    func didGetAdministration()
    func getAdministrationDidFail(error: Error)
}

class AddAdministrationViewModel {
    
    weak var delegate: AddAdministrationViewModelDelegate?
    let endpoint = "/administrations"
    var currentAdministration: Administration?

    // MARK: Public Methods
    
    func post(administrationRequest: AdministrationRequest, avatarImage: UIImage?) {
        delegate?.willPostAdministration()
        
        let _ = APICLient().postMultipartEntity(endpoint: endpoint, parameters: administrationRequest.toJSON(), image: avatarImage, imageKey: "administrationPic") { (administration: Administration?, error) in
            if error != nil {
                self.delegate?.postAdministrationDidFail(error: error!)
            } else {
                self.delegate?.didPostAdministration()
            }
        }
    }
    
    func update(administrationId: String, administrationRequest: AdministrationRequest, avatarImage: UIImage?) {
        delegate?.willUpdateAdministration()
        
        let updateEndpoint = endpoint + "/" + administrationId
        
        let _ = APICLient().putMultipartEntity(endpoint: updateEndpoint, parameters: administrationRequest.toJSON(), image: avatarImage, imageKey: "administrationPic") { (administration: Administration?, error) in
            if error != nil {
                self.delegate?.updateAdministrationDidFail(error: error!)
            } else {
                self.delegate?.didUpdateAdministration()
            }
        }
    }
    
    func getAdministration(administrationId: String) {
        delegate?.willGetAdministration()
        
        let getEndpoint = endpoint + "/" + administrationId
        
        let _ = APICLient().getEntity(endpoint: getEndpoint) { (administration: Administration?, error) in
            if error != nil {
                self.delegate?.getAdministrationDidFail(error: error!)
            } else {
                self.currentAdministration = administration
                self.delegate?.didGetAdministration()
            }
        }
    }
}
