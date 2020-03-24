//
//  Issue.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 05/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import ObjectMapper

class Issue: BaseModel {
    
    var id: String?
    var name: String?
    var description: String?
    var creator: String?
    var assignee: String?
    var pictureUrl: String?
    var priority: String?
    var status: String?
    var createdAt: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
        creator <- map["creator"]
        assignee <- map["assignee"]
        pictureUrl <- map["pictureUrl"]
        priority <- map["priority"]
        status <- map["status"]
        createdAt <- map["createdAt"]
    }
}
