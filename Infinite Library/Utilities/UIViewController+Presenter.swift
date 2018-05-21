//
//  Presenter.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/21/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

extension UIViewController {
    func present(from viewController: UIViewController) {
        guard let presenting = viewController.presentingViewController else { return }
        viewController.dismiss(animated: false) {
            presenting.present(self, animated: true, completion: nil)
        }
    }
}
