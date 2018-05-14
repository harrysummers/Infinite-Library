//
//  AlbumDownloader.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/3/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation
import CoreData

class AlbumDownloader {
    
    private var album: JSONAlbum = JSONAlbum()
    
    func download(_ albumId: String, onComplete:@escaping (_ album: JSONAlbum) -> Void) {
        SpotifyNetworking.retrieveAlbum(with: albumId) { (status, data) in
            self.mapJSONToCoreData(data) {
                onComplete(self.album)
            }
        }
    }
    
    func mapJSONToCoreData(_ data: Data, onComplete:@escaping () -> Void) {
        do {
            album = try JSONDecoder().decode(JSONAlbum.self, from: data)
            
            onComplete()
        } catch let err {
            print(err)
        }
    }
    
    func saveToDatabase() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        _ = album.map(in: context)
        DispatchQueue.main.async {
            CoreDataManager.shared.saveMainContext()
        }
    }
    

    
    func getArt() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        if let id = getArtistId() {
            let artist = Artist.getArtist(with: id, in: context)
            if !albumArtExists(artist?.image_url) {
                getAlbumArt(with: id) { (artistArt) in
                    artist?.image_url = artistArt
                    CoreDataManager.shared.saveMainContext()
                }
            }
        }
    }
    
    
    func getArtistId() -> String? {
        let artists = album.artists
        if let artists = artists, artists.count > 0, let id = artists[0].id {
            return id
        } else {
            return nil
        }
    }
    
    func albumArtExists(_ imageUrl: String?) -> Bool {
        if imageUrl != nil && imageUrl != "" {
            return true
        } else {
            return false
        }
    }
    
    func getAlbumArt(with id: String, _ onComplete:@escaping (_ artistArt: String) -> Void) {
        SpotifyNetworking.retrieveArtist(with: id) { (status, data) in
            DispatchQueue.main.async {
                do {
                    let spotifyArtist = try JSONDecoder().decode(JSONSpotifyArtist.self, from: data)
                    if let images = spotifyArtist.images, images.count > 0 {
                        let image = images[0]
                        onComplete(image.url)
                    } else {
                        onComplete("")
                    }
                    
                } catch let err {
                    print(err)
                    onComplete("")
                }
            }
        }
    }
}
