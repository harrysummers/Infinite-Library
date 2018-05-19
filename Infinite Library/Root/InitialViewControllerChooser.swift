//
//  InitialViewControllerChoose.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/18/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class InitialViewControllerChooser {
    
    var window: UIWindow?
    private var initialViewController: UIViewController?
    private var temporaryViewController: UIViewController?

    init(with window: UIWindow) {
        self.window = window
    }
    
    func show() {
        setTemporaryViewController()
        isLoggedIn { (isValidated) in
            self.chooseInitialViewController(isValidated)
            self.goToInitialViewController()
        }
    }
    
    fileprivate func setTemporaryViewController() {
        temporaryViewController = UIViewController()
        temporaryViewController?.view.backgroundColor = UIColor.CustomColors.spotifyDark
        window?.rootViewController = temporaryViewController
    }
    
    fileprivate func isLoggedIn(_ onComplete:@escaping (_ isValidated: Bool) -> Void) {
        AsyncWebService.shared.getAccessToken { (accessToken, error) in
            if error == nil && accessToken != nil {
                onComplete(false)
            } else {
                onComplete(true)
            }
        }
    }
    
    fileprivate func chooseInitialViewController(_ isValidated: Bool) {
        if !isValidated {
            self.initialViewController = TabViewController()
        } else {
            self.initialViewController = WelcomeViewController()
        }
    }
    
    fileprivate func goToInitialViewController() {
        temporaryViewController?.present(self.initialViewController!, animated: true, completion: nil)
    }
    
    
}
