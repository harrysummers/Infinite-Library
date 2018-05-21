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
    func download(_ albumId: String, onComplete:@escaping (_ status: Bool, _ album: JSONAlbum) -> Void) {
        SpotifyNetworking.retrieveAlbum(with: albumId) { (status, data) in
            self.mapJSONToCoreData(data) {
                onComplete(status, self.album)
            }
        }
    }
    func mapJSONToCoreData(_ data: Data, onComplete:@escaping () -> Void) {
        do {
            album = try JSONDecoder().decode(JSONAlbum.self, from: data)
            onComplete()
        } catch let err {
            onComplete()
            print(err)
        }
    }
    func saveToDatabase(_ onComplete:@escaping () -> Void) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.perform {
            _ = self.album.map(in: context)
            CoreDataManager.shared.saveMainContext()
            onComplete()
        }
    }
    func getArt() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        if let artistId = getArtistId() {
            let artist = Artist.getArtist(with: artistId, in: context)
            if !albumArtExists(artist?.image_url) {
                getAlbumArt(with: artistId) { (artistArt) in
                    artist?.image_url = artistArt
                    context.perform {
                        CoreDataManager.shared.saveMainContext()
                    }
                }
            }
        }
    }
    func getArtistId() -> String? {
        let artists = album.artists
        if let artists = artists, artists.count > 0, let artistId = artists[0].id {
            return artistId
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
    func getAlbumArt(with albumId: String, _ onComplete:@escaping (_ artistArt: String) -> Void) {
        SpotifyNetworking.retrieveArtist(with: albumId) { (_, data) in
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
