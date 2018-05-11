//
//  TabViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/8/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let albumViewController = AlbumsTableViewController()
        albumViewController.tabBarItem = UITabBarItem(title: "Albums", image: #imageLiteral(resourceName: "album"), tag: 0)
        let artistViewController = ArtistsTableViewController()
        artistViewController.tabBarItem = UITabBarItem(title: "Artists", image: #imageLiteral(resourceName: "artist"), tag: 1)
        let viewControllersList = [albumViewController, artistViewController]
        
        viewControllers = viewControllersList.map {
            UINavigationController(rootViewController: $0)
        }
        //delegate = self
        
    }
    
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        let topIndex = IndexPath(row: 0, section: 0)
//        if let vc = viewController as? AlbumsTableViewController {
//            vc.tableView.scrollToRow(at: topIndex, at: .top, animated: true)
//        } else if let vc = viewController as? ArtistsTableViewController {
//            vc.tableView.scrollToRow(at: topIndex, at: .top, animated: true)
//        }
//    }

}
