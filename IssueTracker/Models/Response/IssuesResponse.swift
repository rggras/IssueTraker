//
//  IssuesResponse.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 14/07/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import ObjectMapper

class IssuesResponse: BaseModel {
    
    var pendingIssues: [Issue] = []
    var onGoingIssues: [Issue] = []
    var rejectedIssues: [Issue] = []
    var doneIssues: [Issue] = []
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override func mapping(map: Map) {
        pendingIssues <- map["pendingIssues"]
        onGoingIssues <- map["onGoingIssues"]
        rejectedIssues <- map["rejectedIssues"]
        doneIssues <- map["doneIssues"]
    }
}
