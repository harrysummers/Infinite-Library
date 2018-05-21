//
//  AlbumsTableViewController+SettingsDelegate.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/21/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

extension AlbumsTableViewController: SettingsViewControllerDelegate {
    func didPressLogout() {
        let vc = LoginViewController()
        vc.present(from: self)
    }
}
