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
    static func getArtist(with id: String, in context: NSManagedObjectContext) -> Artist? {
        let request:NSFetchRequest<Artist> = Artist.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "id", ascending: false)
        ]
        request.predicate = NSPredicate(format: "id = %s", id)
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
    

}
