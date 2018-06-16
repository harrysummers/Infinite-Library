//
//  Clipboard.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/18/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit

struct PasteAlbum {
    var albumId: String = ""
    var externalUrl: String = ""
}

class Clipboard {
    var window: UIWindow?
    private var pasteAlbum: PasteAlbum?
    init(with window: UIWindow) {
        self.window = window
    }
    func checkForAlbum() {
        getPasteAlbumFromPasteboard()
        guard let pasteAlbum = pasteAlbum else {
            print("Did not check for album")
            return
        }
        AlbumRetriever(with: pasteAlbum).retrieve { (album, downloader) in
            if let album = album, let downloader = downloader {
                self.showActionSheet(with: album, and: downloader)
            }
        }
    }
    fileprivate func getPasteAlbumFromPasteboard() {
        if let clipboard = UIPasteboard.general.string,
            let idString = clipboard.getAlbumId(),
            let externalUrl = clipboard.getAlbumExternalUrl() {
            pasteAlbum = PasteAlbum(albumId: idString, externalUrl: externalUrl)
        }
    }

    fileprivate func showActionSheet(with album: JSONAlbum, and albumDownloader: AlbumDownloader) {
        DispatchQueue.main.async {
            let addAlbumViewController = AddAlbumViewController()
            addAlbumViewController.modalPresentationStyle = .overCurrentContext
            addAlbumViewController.album = album
            addAlbumViewController.albumDownloader = albumDownloader
            if let root = self.window?.rootViewController,
                let currentViewController = self.getShowingViewController(root) {
                currentViewController.present(addAlbumViewController, animated: true, completion: nil)
            }
        }
    }
    fileprivate func getShowingViewController(_ rootViewController: UIViewController) -> UIViewController? {
        var isRoot = false
        var showViewController: UIViewController? = rootViewController
        while !isRoot {
            if let tempViewController = showViewController?.presentedViewController {
                showViewController = tempViewController
            } else {
                isRoot = true
            }
        }
        return showViewController
    }
}
