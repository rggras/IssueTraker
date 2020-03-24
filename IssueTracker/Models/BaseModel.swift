//
//  BaseModel.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 01/07/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseModel: Mappable {
    
    var message = ""
    
    
    required init?(map: Map) { }
    
    required init() { }
    
    func mapping(map: Map) {
        message <- map["message"]
    }
}

