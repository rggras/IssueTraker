//
//  UIColor+Theme.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 05/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit

extension UIColor {
    @nonobjc class var primary: UIColor {
        return UIColor(red: 77.0 / 255.0, green: 135.0 / 255.0, blue: 89.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var lightPrimary: UIColor {
        return UIColor(red: 210.0 / 255.0, green: 234.0 / 255.0, blue: 208.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var secondary: UIColor {
        return UIColor(red: 109.0 / 255.0, green: 189.0 / 255.0, blue: 125.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var text: UIColor {
        return UIColor(red: 44.0 / 255.0, green: 44.0 / 255.0, blue: 44.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var lightText: UIColor {
        return UIColor(red: 100.0 / 255.0, green: 100.0 / 255.0, blue: 100.0 / 255.0, alpha: 1.0)
    }
}
