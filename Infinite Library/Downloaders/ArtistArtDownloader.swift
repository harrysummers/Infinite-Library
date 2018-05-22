//
//  AlbumArtDownloader.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/19/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation
import CoreData

class ArtistArtDownloader {
    var artists: [Artist]?
    fileprivate var offset = 0
    fileprivate var max = 0
    init(with artists: [Artist]) {
        self.artists = artists
        max = artists.count
    }
    func download(_ onComplete:@escaping () -> Void) {
        getNextArtistArtBatch {
            onComplete()
        }
    }
    fileprivate func getNextArtistArtBatch(_ onComplete:@escaping () -> Void) {
        fetchArtistArtBatch {
            self.offset = self.getUpperLimit()
            if self.shouldRepeatCall() {
                self.getNextArtistArtBatch {
                    onComplete()
                }
            } else {
                onComplete()
            }
        }
    }
    fileprivate func fetchArtistArtBatch(_ onComplete:@escaping () -> Void) {
        let ids = makeIDSForBatch()
        SpotifyNetworking.retrieveArtists(with: ids) { (status, data) in
            if status {
                do {
                    let spotifyArtists = try JSONDecoder().decode(JSONArtists.self, from: data)
                    let jsonArtists = spotifyArtists.artists
                    for artist in jsonArtists {
                        self.saveToCoreData(artist)
                    }
                    onComplete()
                } catch let err {
                    onComplete()
                    print(err)
                }
            } else {
                onComplete()
            }
        }
    }
    fileprivate func shouldRepeatCall() -> Bool {
        return offset < max
    }
    fileprivate func getUpperLimit() -> Int {
        let limit = offset + 50
        if limit >= max {
            return max
        } else {
            return limit
        }
    }
    fileprivate func saveToCoreData(_ artist: JSONSpotifyArtist) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.perform {
            guard let persistentArtist = Artist.getArtist(with: artist.id, in: context) else { return }
            if let images = artist.images, images.count > 0 {
                let image = images[0]
                persistentArtist.image_url = image.url
            }
            CoreDataManager.shared.saveMainContext()
        }
    }
    fileprivate func makeIDSForBatch() -> String {
        var ids = ""
        var isFirst = true
        guard let artists = artists else { return "" }
        if artists.count > 0 {
            let endIndex = getUpperLimit() - 1
            for index in offset...endIndex {
                guard let artistId = artists[index].id else { return "" }
                if isFirst {
                    isFirst = false
                } else {
                    ids.append(",")
                }
                ids.append(artistId)
            }
        }
        return ids
    }
}
