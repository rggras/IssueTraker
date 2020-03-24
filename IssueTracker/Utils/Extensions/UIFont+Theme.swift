//
//  UIFont+Theme.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 05/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit

extension UIFont {

    class var hero: UIFont {
        return UIFont(name: "HelveticaNeue-CondensedBold", size: 38.0)!
    }
    class var header: UIFont {
        return UIFont(name: "HelveticaNeue-CondensedBold", size: 28.0)!
    }
    class var title: UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: 16.0)!
    }
    class var description: UIFont {
        return UIFont(name: "HelveticaNeue", size: 14.0)!
    }
    
    class var smallText: UIFont {
        return UIFont(name: "HelveticaNeue", size: 13.0)!
    }
}
