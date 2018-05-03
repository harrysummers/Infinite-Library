//
//  AlbumDownloader.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/3/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation

class AlbumDownloader {
    
    private var album: Album = Album()
    
    func download(_ albumId: String, onComplete:@escaping (_ album: Album) -> Void) {
        SpotifyNetworking.retrieveAlbum(with: albumId) { (status, data) in
            self.mapJSONToSwift(data) {
                onComplete(self.album)
            }
        }
    }
    
    func mapJSONToSwift(_ data: Data, onComplete:@escaping () -> Void) {
        do {
            album = try JSONDecoder().decode(Album.self, from: data)
            onComplete()
        } catch let err {
            print(err)
        }
    }
}
