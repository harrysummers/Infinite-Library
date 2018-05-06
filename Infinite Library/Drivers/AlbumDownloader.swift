//
//  AlbumDownloader.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/3/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation

class AlbumDownloader {
    
    private var album: JSONAlbum = JSONAlbum()
    
    func download(_ albumId: String, onComplete:@escaping (_ album: JSONAlbum) -> Void) {
        SpotifyNetworking.retrieveAlbum(with: albumId) { (status, data) in
            self.mapJSONToSwift(data) {
                onComplete(self.album)
            }
        }
    }
    
    func mapJSONToSwift(_ data: Data, onComplete:@escaping () -> Void) {
        do {
            album = try JSONDecoder().decode(JSONAlbum.self, from: data)
            onComplete()
        } catch let err {
            print(err)
        }
    }
}
