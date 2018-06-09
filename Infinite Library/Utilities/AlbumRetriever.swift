//
//  AlbumRetriever.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 6/9/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation

class AlbumRetriever {
    private var pasteAlbum: PasteAlbum?
    init(with album: PasteAlbum) {
        self.pasteAlbum = album
    }
    func retrieve(_ onComplete:@escaping (_ album: JSONAlbum?, _ downloader: AlbumDownloader?) -> Void) {
        if checkIsLoggedIn() {
            if !isInCoreData() {
                downloadAlbum { (album, downloader) in
                    onComplete(album, downloader)
                }
            } else {
                onComplete(nil, nil)
            }
        } else {
            onComplete(nil, nil)
        }
    }
    fileprivate func checkIsLoggedIn() -> Bool {
        return UserDefaultsHelper.shared.getLoggedIn()
    }
    fileprivate func isInCoreData() -> Bool {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        return Album.isAlreadyInCoreData(with: pasteAlbum?.externalUrl ?? "", with: context)
    }
    fileprivate func downloadAlbum(_ onComplete:@escaping (_ album: JSONAlbum?,
        _ downloader: AlbumDownloader?) -> Void) {
        let albumDownloader = AlbumDownloader()
        albumDownloader.download(pasteAlbum?.albumId ?? "") { (status, album) in
            if status {
                onComplete(album, albumDownloader)
            } else {
                onComplete(nil, nil)
            }
        }
    }
}
