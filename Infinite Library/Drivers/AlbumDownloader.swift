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
}
