//
//  Dashboard.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 08/07/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import ObjectMapper

class Dashboard: BaseModel {
    
    var administrations: [Administration] = []
    var pendingInvites: [Invite] = []
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        administrations <- map["administrations"]
        pendingInvites <- map["pendingInvites"]
    }
}
