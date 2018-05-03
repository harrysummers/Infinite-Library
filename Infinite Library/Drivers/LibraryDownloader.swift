//
//  LibraryDownloader.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/3/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation

class LibraryDownloader {
    
    private var library = Library()
    
    func download(onComplete:@escaping (_ albums: Library) -> Void) {
        SpotifyNetworking.retrieveAllAlbums { (status, data) in
            self.convertDataToAlbums(data) {
                onComplete(self.library)
            }
        }
    }
    
    func convertDataToAlbums(_ data: Data, onComplete:@escaping () -> Void) {
        do {
            library = try JSONDecoder().decode(Library.self, from: data)
            onComplete()
        } catch let err {
            print(err)
        }
        
    }
    
}
