//
//  User.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 01/07/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import ObjectMapper

class User: BaseModel {
    
    var id: String?
    var idToken: String?
    var name: String?
    var email: String?
    var phone: String?
    var auth0Id: String?
    var pictureUrl: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        phone <- map["phone"]
        auth0Id <- map["auth0Id"]
        pictureUrl <- map["pictureUrl"]
    }
}
