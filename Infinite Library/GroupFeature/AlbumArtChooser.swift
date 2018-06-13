//
//  AlbumArtChooser.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 6/13/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation

class AlbumArtChooser {
    var group: Group?
    init(with group: Group) {
        self.group = group
    }
    func getAlbumArtUrl() -> URL? {
        if let albums = group?.albums, albums.count > 0 {
            let album = albums.anyObject() as? Album
            let url = URL(string: album?.image_url ?? "")
            return url
        }
        return nil
    }
}
