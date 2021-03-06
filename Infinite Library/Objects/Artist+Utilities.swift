//
//  Artist+Utilities.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/8/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation
import CoreData

extension Artist {
    static func getArtist(with artistId: String, in context: NSManagedObjectContext) -> Artist? {
        let request: NSFetchRequest<Artist> = Artist.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "id", ascending: false)
        ]
        request.predicate = NSPredicate(format: "id = %@", artistId)
        request.fetchLimit = 1
        do {
            let artists = try context.fetch(request)
            if artists.count > 0 {
                return artists[0]
            } else {
                return nil
            }
        } catch let err {
            print(err)
        }
        return nil
    }
    static func getAllArtists(in context: NSManagedObjectContext) -> [Artist] {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let request = NSFetchRequest<Artist>(entityName: "Artist")
        do {
            return try context.fetch(request)
        } catch let err {
            print(err)
            return []
        }
    }
}
