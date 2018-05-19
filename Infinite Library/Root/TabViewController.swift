//
//  TabViewController.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/8/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController, UITabBarControllerDelegate {

    var albumTabCount = 0
    var artistTabCount = 0
    
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
        delegate = self
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let topIndex = IndexPath(row: 0, section: 0)
        if let navController = viewController as? UINavigationController,
            navController.childViewControllers.count > 0 {
            let childController = navController.childViewControllers[0]
            if let vc = childController as? AlbumsTableViewController {
                artistTabCount = 0
                if albumTabCount > 1 {
                    let count = vc.getAlbumCount(for: topIndex.section)
                    if count > 0 {
                        vc.tableView.scrollToRow(at: topIndex, at: .top, animated: true)
                    }
                    albumTabCount = 0
                } else {
                     albumTabCount = albumTabCount + 1
                }
            } else if let vc = childController as? ArtistsTableViewController {
                albumTabCount = 0
                if artistTabCount > 1 {
                    let count = vc.getArtistCount(for: topIndex.section)
                    if count > 0 {
                        vc.tableView.scrollToRow(at: topIndex, at: .top, animated: true)
                    }
                    artistTabCount = 0
                } else {
                    artistTabCount = artistTabCount + 1
                }
            }
        }

    }
    

}
