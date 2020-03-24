//
//  APIEnvironments.swift
//  LCPremium
//
//  Created by Rodrigo Gras on 12/02/2019.
//  Copyright © 2019 Progentec Diagnostics, Inc. All rights reserved.
//

import Foundation

class APIEnvironments {
    
    enum apiEnvironment: String {
        case development    = "development"
        case production     = "production"
        case none           = ""
    }
    
    var environment: String {
        get {
            return Bundle.main.object(forInfoDictionaryKey: Constants.Plist.apiEnvironmentKey) as? String ?? ""
        }
    }
    
    func apiPath(_ endpoint: String) -> String {
        
        let baseUrl : String!
        switch environment {
        case apiEnvironment.development.rawValue:
            baseUrl = "http://issue-tracker-api-dev.us-east-1.elasticbeanstalk.com/service"
            
        case apiEnvironment.production.rawValue:
            // TODO: put the final prod Url
            baseUrl  = "http://issue-tracker-api-dev.us-east-1.elasticbeanstalk.com/service"
            
        default:
            // TODO: put the final prod url
            baseUrl  = "http://issue-tracker-api-dev.us-east-1.elasticbeanstalk.com/service"
        }
        
        return baseUrl + endpoint;
    }
}
