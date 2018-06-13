//
//  Group+Utilities.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 6/13/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation
import CoreData

extension Group {
    static func nameAlreadyExists(_ name: String) -> Bool {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let request: NSFetchRequest = Group.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        request.fetchLimit = 1
        do {
            let group = try context.fetch(request)
            return group.count > 0
        } catch let err {
            print(err)
            return false
        }
    }
}
