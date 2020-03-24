//
//  Priority.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 12/07/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import ObjectMapper

class Priority: BaseModel {
    
    var id: String?
    var name: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
