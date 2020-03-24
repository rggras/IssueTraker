//
//  CharacterSet+Unreserved.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 15/07/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import Foundation

extension CharacterSet {
    static let rfc3986Unreserved = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~")
}
