//
//  AdministrationRequest.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 10/07/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import ObjectMapper

class AdministrationRequest: BaseModel {
    
    var name: String?
    var address: String?
    var city: String?
    var country: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        name <- map["name"]
        address <- map["address"]
        city <- map["city"]
        country <- map["country"]
    }
}
