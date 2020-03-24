//
//  FirstLaunch.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 04/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import Foundation

final class FirstLaunch {
    
    let wasLaunchedBefore: Bool
    var isFirstLaunch: Bool {
        return !wasLaunchedBefore
    }
    
    init(getWasLaunchedBefore: () -> Bool, setWasLaunchedBefore: (Bool) -> ()) {
        let wasLaunchedBefore = getWasLaunchedBefore()
        self.wasLaunchedBefore = wasLaunchedBefore
        
        if !wasLaunchedBefore {
            setWasLaunchedBefore(true)
        }
    }
    
    convenience init(userDefaults: UserDefaults, key: String) {
        self.init(
            getWasLaunchedBefore: { userDefaults.bool(forKey: key) },
            setWasLaunchedBefore: { userDefaults.set($0, forKey: key) }
        )
    }
}

