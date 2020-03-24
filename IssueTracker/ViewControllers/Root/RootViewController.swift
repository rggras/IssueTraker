//
//  RootViewController.swift
//  IssueTracker
//
//  Created by Rodrigo Gras on 04/06/2019.
//  Copyright © 2019 Nexton Labs. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private var current: UIViewController?
    
    // MARK: Initializers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: Properties
    
    var walkthrough: WalkthroughViewController {
        let storyboard = UIStoryboard(name: "Walkthrough", bundle: nil)
        return storyboard.instantiateInitialViewController() as! WalkthroughViewController
    }
    
    var login: LoginViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        return  storyboard.instantiateInitialViewController() as! LoginViewController
    }
    
    var issues: UINavigationController {
        let storyboard = UIStoryboard(name: "Issues", bundle: nil)
        return storyboard.instantiateInitialViewController() as! UINavigationController
    }
    
    var main: UITabBarController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateInitialViewController() as! UITabBarController
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaultsManager = UserDefaultsManager(userDefaults: .standard)
        if userDefaultsManager.auth0IdToken != nil {
            if userDefaultsManager.currentAdministrationId != nil {
                current = issues
            } else {
                current = main
            }
        } else if userDefaultsManager.walkthroughWasLaunched {
            current = login
        } else {
            userDefaultsManager.walkthroughWasLaunched = true
            current = walkthrough
        }

        addChild(current!)
        current!.view.frame = view.bounds
        view.addSubview(current!.view)
        current!.didMove(toParent: self)
    }
    
    // MARK: Private Methods
    
    private func animateFadeTransition(to new: UIViewController) {
        if let _current = current {
            _current.willMove(toParent: nil)
            addChild(new)
            
            transition(from: _current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
            }) { completed in
                _current.removeFromParent()
                new.didMove(toParent: self)
                self.current = new
            }
        }
    }
    
    // MARK: Public Methods

    func switchToMain() {
        animateFadeTransition(to: main)
    }
    
    func switchToLogin() {
        animateFadeTransition(to: login)
    }
    
    func switchToIssues() {
        animateFadeTransition(to: issues)
    }
}
