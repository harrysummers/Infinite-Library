//
//  SpotifyNetworking.swift
//  Infinite Library
//
//  Created by Harry Summers on 5/2/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation

class SpotifyNetworking {
    static func retrieveAlbum(with id: String, onComplete:@escaping (_ success: Bool, _ data: Data) -> Void) {
        let url: URL = URL(string: Endpoints.SPOTIFY_ALBUMS + id)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        AsyncWebService.shared.sendAsyncRequest(request: request) { (status, responseData) in
            if (status == 200) {
                onComplete(true, responseData)
            } else {
                onComplete(false, responseData)
            }
        }
    }
    
    static func retrieveAllAlbums(_ offset: Int, onComplete:@escaping (_ success: Bool, _ data: Data) -> Void) {
        let urlString = "\(Endpoints.SPOTIFY_LIBRARY_ALBUMS)?limit=20&offset=\(offset)"
        guard let url: URL = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        AsyncWebService.shared.sendAsyncRequest(request: request) { (status, responseData) in
            print(responseData)
            if (status == 200) {
                onComplete(true, responseData)
            } else {
                onComplete(false, responseData)
            }
        }
    }
}

