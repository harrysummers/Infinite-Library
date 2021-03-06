//
//  Album+Utilities.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/7/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation
import CoreData

extension Album {
    static func getAlbum(with externalUrl: String, in context: NSManagedObjectContext) -> Album? {
        let request: NSFetchRequest<Album> = Album.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: false)
        ]
        request.predicate = NSPredicate(format: "external_url = %@", externalUrl)
        request.fetchLimit = 1
        do {
            let albums = try context.fetch(request)
            if albums.count > 0 {
                return albums[0]
            } else {
                return nil
            }
        } catch let err {
            print(err)
        }
        return nil
    }
    static func isAlreadyInCoreData(with externalUrl: String, with context: NSManagedObjectContext) -> Bool {
        let album = getAlbum(with: externalUrl, in: context)
        if album == nil {
            return false
        } else {
            return true
        }
    }
    public override func prepareForDeletion() {
        if let artist = artist {
            let albums = artist.albums
            if albums == nil || albums?.count == 1 {
                managedObjectContext?.delete(artist)
            }
        }
    }
    static func getAlbumCount(in context: NSManagedObjectContext) -> Int {
        let request: NSFetchRequest<Album> = Album.fetchRequest()
        do {
            let albums = try context.fetch(request)
            return albums.count
        } catch let err {
            print(err)
            return 0
        }

    }
}
