//
//  UserDefaultsManager.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 21/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    
    var defaults: UserDefaults?
    
    convenience init(userDefaults: UserDefaults) {
        self.init()
        defaults = userDefaults
    }
    
    var auth0IdToken: String? {
        get {
            if let defaults = defaults {
                return defaults.string(forKey: Constants.UserDefaults.auth0IdTokenKey)
            }
            
            return nil
        }
        set(newValue) {
            if let defaults = defaults {
                defaults.set(newValue, forKey: Constants.UserDefaults.auth0IdTokenKey)
            }
        }
    }
    
    var walkthroughWasLaunched: Bool {
        get {
            if let defaults = defaults {
                return defaults.bool(forKey: Constants.UserDefaults.walkthroughWasLaunchedKey)
            }
            
            return false
        }
        set(newValue) {
            if let defaults = defaults {
                defaults.set(newValue, forKey: Constants.UserDefaults.walkthroughWasLaunchedKey)
            }
        }
    }
    
    var currentAdministrationId: String? {
        get {
            if let defaults = defaults {
                return defaults.string(forKey: Constants.UserDefaults.currentAdministrationIdKey)
            }
            
            return nil
        }
        set(newValue) {
            if let defaults = defaults {
                defaults.set(newValue, forKey: Constants.UserDefaults.currentAdministrationIdKey)
            }
        }
    }
    
    var currentAdministrationRole: Constants.Roles {
        get {
            if let defaults = defaults {
                return Constants.Roles(rawValue: defaults.string(forKey: Constants.UserDefaults.currentAdministrationRoleKey) ?? "")!
            }
            
            return Constants.Roles.none
        }
        set(newValue) {
            if let defaults = defaults {
                defaults.set(newValue.rawValue, forKey: Constants.UserDefaults.currentAdministrationRoleKey)
            }
        }
    }
    
    var currentAdministrationName: String? {
        get {
            if let defaults = defaults {
                return defaults.string(forKey: Constants.UserDefaults.currentAdministrationNameKey)
            }
            
            return nil
        }
        set(newValue) {
            if let defaults = defaults {
                defaults.set(newValue, forKey: Constants.UserDefaults.currentAdministrationNameKey)
            }
        }
    }
}
