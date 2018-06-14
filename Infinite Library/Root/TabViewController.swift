//
//  TabViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/8/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let albumViewController = AlbumsTableViewController()
        albumViewController.tabBarItem = UITabBarItem(title: "Albums", image: #imageLiteral(resourceName: "album"), tag: 0)
        let artistViewController = ArtistsTableViewController()
        artistViewController.tabBarItem = UITabBarItem(title: "Artists", image: #imageLiteral(resourceName: "artist"), tag: 1)
        let groupViewController = GroupsCollectionViewController()
        groupViewController.tabBarItem = UITabBarItem(title: "Groups", image: #imageLiteral(resourceName: "folder"), tag: 2)
        let viewControllersList = [albumViewController, artistViewController, groupViewController]
        viewControllers = viewControllersList.map {
            UINavigationController(rootViewController: $0)
        }
    }
}
