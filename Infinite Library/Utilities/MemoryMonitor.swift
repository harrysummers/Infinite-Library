//
//  MemoryMonitor.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/20/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation

struct MemoryCounter {
    
    static var shared = MemoryCounter()
    private var settingsViewControllerCount = 0
    private var albumsTableViewControllerCount = 0
    private var addAlbumViewCountrollerCount = 0
    private var artistsTableViewControllerCount = 0
    private var loginViewControllerCount = 0
    private var autoLoginViewControllerCount = 0
    private var libraryDownloadViewControllerCount = 0
    private var tutorialScreenViewControllerCount = 0
    private var welcomeViewControllerCount = 0
    
    
    func incrementCount(for viewController: ViewControllerType) {
        switch viewController {
        case .settingsViewController:
            MemoryCounter.shared.settingsViewControllerCount += 1
            MemoryCounter.shared.printCount(for: .settingsViewController)
            break
        case .albumsTableViewController:
            MemoryCounter.shared.albumsTableViewControllerCount += 1
            MemoryCounter.shared.printCount(for: .albumsTableViewController)
        case .addAlbumViewController:
            MemoryCounter.shared.addAlbumViewCountrollerCount += 1
            MemoryCounter.shared.printCount(for: .addAlbumViewController)
        case .artistsTableViewController:
            MemoryCounter.shared.artistsTableViewControllerCount += 1
            MemoryCounter.shared.printCount(for: .artistsTableViewController)
        case .loginViewController:
            MemoryCounter.shared.loginViewControllerCount += 1
            MemoryCounter.shared.printCount(for: .loginViewController)
        case .autoLoginViewController:
            MemoryCounter.shared.autoLoginViewControllerCount += 1
            MemoryCounter.shared.printCount(for: .artistsTableViewController)
        case .libraryDownloadViewController:
            MemoryCounter.shared.libraryDownloadViewControllerCount += 1
            MemoryCounter.shared.printCount(for: .libraryDownloadViewController)
        case .welcomeViewController:
            MemoryCounter.shared.welcomeViewControllerCount += 1
            MemoryCounter.shared.printCount(for: .welcomeViewController)
        case .tutorialScreenViewController:
            MemoryCounter.shared.tutorialScreenViewControllerCount += 1
            MemoryCounter.shared.printCount(for: .tutorialScreenViewController)
        }
    }
    
    func decrementCount(for viewController: ViewControllerType) {
        switch viewController {
        case .settingsViewController:
            MemoryCounter.shared.settingsViewControllerCount -= 1
            MemoryCounter.shared.printCount(for: .settingsViewController)
            break
        case .albumsTableViewController:
            MemoryCounter.shared.albumsTableViewControllerCount -= 1
            MemoryCounter.shared.printCount(for: .albumsTableViewController)
        case .addAlbumViewController:
            MemoryCounter.shared.addAlbumViewCountrollerCount -= 1
            MemoryCounter.shared.printCount(for: .addAlbumViewController)
        case .artistsTableViewController:
            MemoryCounter.shared.artistsTableViewControllerCount -= 1
            MemoryCounter.shared.printCount(for: .artistsTableViewController)
        case .loginViewController:
            MemoryCounter.shared.loginViewControllerCount -= 1
            MemoryCounter.shared.printCount(for: .loginViewController)
        case .autoLoginViewController:
            MemoryCounter.shared.autoLoginViewControllerCount -= 1
            MemoryCounter.shared.printCount(for: .autoLoginViewController)
        case .libraryDownloadViewController:
            MemoryCounter.shared.libraryDownloadViewControllerCount -= 1
            MemoryCounter.shared.printCount(for: .libraryDownloadViewController)
        case .welcomeViewController:
            MemoryCounter.shared.welcomeViewControllerCount -= 1
            MemoryCounter.shared.printCount(for: .welcomeViewController)
        case .tutorialScreenViewController:
            MemoryCounter.shared.tutorialScreenViewControllerCount -= 1
            MemoryCounter.shared.printCount(for: .tutorialScreenViewController)
        }
    }
    
    fileprivate func printCount(for viewController: ViewControllerType) {
        switch viewController {
        case .settingsViewController:
            print("settingsViewController count = \(settingsViewControllerCount)")
            break
        case .albumsTableViewController:
            print("albumsTableViewController count = \(albumsTableViewControllerCount)")
            break
        case .addAlbumViewController:
            print("addAlbumViewController count = \(addAlbumViewCountrollerCount)")
        case .artistsTableViewController:
            print("artistsTableViewController count = \(artistsTableViewControllerCount)")
        case .loginViewController:
            print("loginViewController count = \(loginViewControllerCount)")
        case .autoLoginViewController:
            print("autoLoginViewController count = \(autoLoginViewControllerCount)")
        case .libraryDownloadViewController:
            print("libraryDownloadViewController count = \(libraryDownloadViewControllerCount)")
        case .welcomeViewController:
            print("welcomeViewController count = \(welcomeViewControllerCount)")
        case .tutorialScreenViewController:
            print("tutorialScreenViewController count = \(tutorialScreenViewControllerCount)")
        }
    }
    
}
