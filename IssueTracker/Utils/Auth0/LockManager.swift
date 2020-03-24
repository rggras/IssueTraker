//
//  LockManager.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 05/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import Foundation
import Lock
import Auth0

protocol LockManagerDelegate: class {
    func didAuth(credentials: Credentials, profile: Profile)
}

class LockManager {
    
    weak var delegate: LockManagerDelegate?
    
    func showAuthScreen(presenter: UIViewController) {
        Lock
            .classic()
            .withOptions {
                $0.closable = true
                $0.oidcConformant = true
                $0.allow = [.Signup, .Login, .ResetPassword]
                $0.scope = "openid profile email read:current_user update:current_user_metadata"
                $0.audience = "https://issue-tracker.auth0.com/api/v2/"
            }
            .withConnections { connections in
                connections.database(name: "Username-Password-Authentication", requiresUsername: true)
            }
            .withStyle {
                $0.hideTitle = true
                $0.logo = LazyImage(name: "NextonLogo")
                $0.primaryColor = .secondary
                $0.headerColor = .clear
            }
            .onAuth { credentials in
                self.getProfile(accessToken: credentials.accessToken, completion: { (profile) in
                    self.delegate?.didAuth(credentials: credentials, profile: profile)
                })
            }
            .onError(callback: { (error) in
                print(error)
            })
            .present(from: presenter)
    }
    
    func getProfile(accessToken: String?, completion:@escaping (_ profile: Profile) -> ()) {
        if let token = accessToken {
            Auth0
                .authentication()
                .userInfo(token: token)
                .start { result in
                    switch result {
                    case .success(let profile):
                        completion(profile)
                    default:
                        print("LockManager: Error trying to get the User Profile from Auth0")
                    }
            }
        } else {
            print("LockManager: wrong accessToken")
        }
    }
}

