//
//  Invite.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 08/07/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import ObjectMapper

class Invite: BaseModel {
    
    var id: String?
    var status: String?
    var administrationId: String?
    var administrationName: String?
    var administrationPictureUrl: String?
    var createdAt: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        id <- map["id"]
        status <- map["status"]
        administrationId <- map["administrationId"]
        administrationName <- map["administrationName"]
        administrationPictureUrl <- map["administrationPictureUrl"]
        createdAt <- map["createdAt"]
    }
}
