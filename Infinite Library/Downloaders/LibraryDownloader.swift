//
//  LibraryDownloader.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/3/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import UIKit
import CoreData

class LibraryDownloader {
    
    private var library = JSONLibrary()
    private let BATCH_SIZE = 20
    var progressCounter: ProgressCounter?
    
    func download(onComplete:@escaping (_ albums: JSONLibrary) -> Void) {
        self.recursiveDownload(0) {
            self.saveToDatabase {
                self.getAllAlbumArt {
                    DispatchQueue.main.async {
                        self.progressCounter?.complete()
                    }
                    onComplete(self.library)
                }
            }
        }
    }
    
    func recursiveDownload(_ offset: Int, onComplete:@escaping () -> Void) {
        SpotifyNetworking.retrieveAllAlbums(offset) { (status, data) in
            self.convertDataToAlbums(data, self.isFirstBatch(offset)) { shouldRepeat in
                DispatchQueue.main.async {
                    self.progressCounter?.increment()
                }
                if shouldRepeat {
                    let nextBatch = offset + 20
                    self.recursiveDownload(nextBatch) {
                        onComplete()
                    }
                } else {
                    onComplete()
                }
            }
        }
    }
    
    private func isFirstBatch(_ offset: Int) -> Bool {
        return offset == 0
    }
    
    private func convertDataToAlbums(_ data: Data, _ isFirstBatch: Bool, onComplete:@escaping (_ shouldGetNextBatch: Bool) -> Void) {
        do {
            let newLibrary = try JSONDecoder().decode(JSONLibrary.self, from: data)

            var shouldRepeat = false
            if let libraryCount = newLibrary.items?.count, libraryCount > 0 {
                shouldRepeat = true
            }
            
            if isFirstBatch {
                library = newLibrary
            } else {
                for libraryAlbum in newLibrary.items! {
                    library.items?.append(libraryAlbum)
                }
            }
            onComplete(shouldRepeat)
        } catch let err {
            print(err)
            onComplete(false)
        }
        
    }
    
    private func saveToDatabase(_ onComplete:@escaping () -> Void) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        guard let items = library.items else { return }
        
        context.perform {
            for libraryAlbum in items {
                _ = libraryAlbum.album?.map(in: context)
                CoreDataManager.shared.saveMainContext()
                DispatchQueue.main.async {
                    self.progressCounter?.increment()
                }
            }
            onComplete()
        }

    }
    
    func getAllAlbumArt(_ onComplete:@escaping () -> Void) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let artists = Artist.getAllArtists(in: context)
        let artistCount = artists.count
        var completedCount = 0
        for artist in artists {
            if let id = artist.id {
                getAlbumArt(with: id) { (artistArt) in
                    context.perform {
                        artist.image_url = artistArt
                        CoreDataManager.shared.saveMainContext()
                        completedCount = completedCount + 1
                        if completedCount == artistCount {
                            onComplete()
                        }
                    }
                }
            }
        }
    }
    
    func getAlbumArt(with id: String, _ onComplete:@escaping (_ artistArt: String) -> Void) {
        SpotifyNetworking.retrieveArtist(with: id) { (status, data) in
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
