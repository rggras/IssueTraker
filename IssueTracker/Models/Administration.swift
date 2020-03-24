//
//  Administration.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 21/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import ObjectMapper

class Administration: BaseModel {
    
    var id: String?
    var name: String?
    var address: String?
    var city: String?
    var country: String?
    var pictureUrl: String?
    var createdAt: String?
    var role = Constants.Roles.none
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        address <- map["address"]
        city <- map["city"]
        country <- map["country"]
        pictureUrl <- map["pictureUrl"]
        createdAt <- map["createdAt"]
        role <- (map["role"], EnumTransform<Constants.Roles>())
    }
}
