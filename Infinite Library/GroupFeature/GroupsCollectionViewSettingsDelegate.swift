//
//  GroupsCollectionViewSettingsDelegate.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 6/13/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

extension GroupsCollectionViewController: SettingsViewControllerDelegate {
    func didPressLogout() {
        let viewController = LoginViewController()
        viewController.present(from: self)
    }
}
