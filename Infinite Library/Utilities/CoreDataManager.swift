//
//  CoreDataManager.swit.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/6/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Infinite_Library")
        container.loadPersistentStores(completionHandler: { (_, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        })
        return container
    }()
    func saveMainContext() {
        do {
            try persistentContainer.viewContext.save()
        } catch let saveErr {
            print("Failed to save note: ", saveErr)
        }
    }
    func clear() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.perform {
            do {
                let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Album")
                let request = NSBatchDeleteRequest(fetchRequest: fetch)
                _ = try context.execute(request)
            } catch let err {
                print(err)
            }
        }
    }
}
