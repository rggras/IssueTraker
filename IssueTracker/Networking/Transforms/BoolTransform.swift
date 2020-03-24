//
//  BoolTransform.swift
//  LCPremium
//
//  Created by Rodrigo Gras on 13/02/2019.
//  Copyright © 2019 Progentec Diagnostics, Inc. All rights reserved.
//

import UIKit
import ObjectMapper

class BoolTransform: TransformType {

    public typealias Object = Bool
    public typealias JSON = AnyObject

    open func transformFromJSON(_ value: Any?) -> Object? {
        if  let valueU = value {
            let valueString = String(describing: valueU)
            switch valueString {
            case "True", "true", "yes", "1", "SI":
                return true
            case "False", "false", "no", "0", "NO":
                return false
            default:
                return nil
            }
        }
        return nil
    }
    
    open func transformToJSON(_ value: Object?) -> JSON? {
        if let aValue = value {
            if (aValue) {
                return "true" as BoolTransform.JSON
            }
            else {
                return "false" as BoolTransform.JSON
            }
        }
        return nil
    }
}
