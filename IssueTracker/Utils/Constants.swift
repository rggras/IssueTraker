//
//  Constants.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 04/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit

struct Constants {
    
    struct UserDefaults {
        static let walkthroughWasLaunchedKey = "walkthroughWasLaunched"
        static let auth0IdTokenKey = "auth0IdToken"
        static let currentAdministrationIdKey = "currentAdministrationId"
        static let currentAdministrationRoleKey = "currentAdministrationRole"
        static let currentAdministrationNameKey = "currentAdministrationName"
    }
    
    struct Plist {
        static let apiEnvironmentKey = "APIEnvironment"
    }
    
    struct Error {
        static let domain = "com.nexton.issuetracker.networking"
        static let defaultMessage = "Unexpected error occurred."
    }
    
    struct Notifications {
        static let unauthorizedNotificationKey = "unauthorizedNotification"
    }
    
    enum Roles : String {
        case editor = "editor"
        case admin  = "admin"
        case none   = ""
    }
}

extension Notification.Name {
    static let unauthorized = Notification.Name(Constants.Notifications.unauthorizedNotificationKey)
}
