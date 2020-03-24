//
//  AdministrationsViewModel.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 21/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import Foundation

struct AdministrationSectionType: OptionSet {
    let rawValue: Int
    
    static let invites = AdministrationSectionType(rawValue: 0)
    static let administrations = AdministrationSectionType(rawValue: 1)
}

protocol AdministrationsViewModelDelegate: class {
    func willGetAdministrations()
    func didGetAdministrations()
    func getAdministrationsDidFail(error: Error)
    func willAcceptInvite()
    func didAcceptInvite()
    func acceptInviteDidFail(error: Error)
    func willDeleteInvite()
    func didDeleteInvite()
    func deleteInviteDidFail(error: Error)
}

class AdministrationsViewModel {
    
    weak var delegate: AdministrationsViewModelDelegate?
    let dashboardEndpoint = "/users/dashboard"
    let inviteEndpoint = "/users/invites"
    var dashboard: Dashboard?
    let sections: [AdministrationSectionType] = [.invites, .administrations]
    
    // MARK: Public Methods
    
    func getAdministrations() {
        delegate?.willGetAdministrations()
        
        
        let _ = APICLient().getEntity(endpoint: dashboardEndpoint) { (dashboard: Dashboard?, error) in
            if error != nil {
                self.delegate?.getAdministrationsDidFail(error: error!)
            } else {
                self.dashboard = dashboard!
                self.delegate?.didGetAdministrations()
            }
        }
    }
    
    func acceptInvite(id: String?) {
        delegate?.willAcceptInvite()
        
        let endpoint = inviteEndpoint + "/" + (id ?? "")
        
        let _ = APICLient().putEntity(endpoint: endpoint) { (response: BaseModel?, error) in
            if error != nil {
                self.delegate?.acceptInviteDidFail(error: error!)
            } else {
                self.delegate?.didAcceptInvite()
            }
        }
    }
    
    func declineInvite(id: String?) {
        delegate?.willDeleteInvite()
        
        let endpoint = inviteEndpoint + "/" + (id ?? "")
        
        let _ = APICLient().deleteEntity(endpoint: endpoint) { (response: BaseModel?, error) in
            if error != nil {
                self.delegate?.deleteInviteDidFail(error: error!)
            } else {
                self.delegate?.didDeleteInvite()
            }
        }
    }
    
    func items(forType type: AdministrationSectionType) -> [AnyObject] {
        switch type {
            case .invites:
                return dashboard?.pendingInvites ?? []
            case .administrations:
                return dashboard?.administrations ?? []
            default:
                return []
        }
    }
}
