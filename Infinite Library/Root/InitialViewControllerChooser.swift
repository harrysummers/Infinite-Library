//
//  InitialViewControllerChoose.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/18/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class InitialViewControllerChooser {
    private var initialViewController: UIViewController?

    func show(_ onComplete:@escaping (_ viewController: UIViewController?) -> Void) {
        isLoggedIn { (isValidated) in
            self.chooseInitialViewController(isValidated)
            guard let viewController = self.initialViewController else {
                onComplete(nil)
                return
            }
            onComplete(viewController)
        }
    }
    fileprivate func isLoggedIn(_ onComplete:@escaping (_ isValidated: Bool) -> Void) {
        AsyncWebService.shared.getAccessToken { (accessToken, error) in
            if error != nil || accessToken == nil {
                onComplete(false)
            } else {
                onComplete(true)
            }
        }
    }
    fileprivate func chooseInitialViewController(_ isValidated: Bool) {
        if isValidated {
            initialViewController = TabViewController()
        } else {
            initialViewController = WelcomeViewController()
        }
    }
}
