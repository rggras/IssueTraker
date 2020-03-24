//
//  IssueRequest.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 12/07/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import ObjectMapper

class IssueRequest: BaseModel {
    
    var name: String?
    var description: String?
    var priorityId: String?
    var statusId: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        name <- map["name"]
        description <- map["description"]
        priorityId <- map["priorityId"]
        statusId <- map["statusId"]
    }
}
