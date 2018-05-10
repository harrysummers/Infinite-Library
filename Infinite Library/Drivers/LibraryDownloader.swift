//
//  LibraryDownloader.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/3/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation

class LibraryDownloader {
    
    private var library = JSONLibrary()
    private let BATCH_SIZE = 20
    
    func download(onComplete:@escaping (_ albums: JSONLibrary) -> Void) {
        recursiveDownload(0) {
            self.saveToDatabase()
            onComplete(self.library)
        }
    }
    
    func recursiveDownload(_ offset: Int, onComplete:@escaping () -> Void) {
        SpotifyNetworking.retrieveAllAlbums(offset) { (status, data) in
            self.convertDataToAlbums(data, self.isFirstBatch(offset)) { shouldRepeat in
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
    
    func convertDataToAlbums(_ data: Data, _ isFirstBatch: Bool, onComplete:@escaping (_ shouldGetNextBatch: Bool) -> Void) {
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
        }
        
    }
    
    func saveToDatabase() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        guard let items = library.items else { return }
        for libraryAlbum in items {
            _ = libraryAlbum.album?.map(in: context)
            CoreDataManager.shared.saveMainContext()
        }
    }
    
}
