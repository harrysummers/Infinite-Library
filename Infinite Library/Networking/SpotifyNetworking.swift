//
//  SpotifyNetworking.swift
//  Infinite Library
//
//  Created by Harry Summers on 5/2/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation

class SpotifyNetworking {
    static func retrieveAlbum(with albumId: String,
                              onComplete:@escaping (_ success: Bool, _ data: Data) -> Void) {
        let url: URL = URL(string: Endpoints.spotifyAlbums + albumId)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        AsyncWebService.shared.sendAsyncRequest(request: request) { (status, responseData) in
            onComplete(status == 200, responseData)
        }
    }
    static func retrieveAllAlbums(_ offset: Int, onComplete:@escaping (_ success: Bool, _ data: Data) -> Void) {
        let urlString = "\(Endpoints.spotifyLibraryAlbums)?limit=20&offset=\(offset)"
        guard let url: URL = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        AsyncWebService.shared.sendAsyncRequest(request: request) { (status, responseData) in
            onComplete(status == 200, responseData)
        }
    }
    static func retrieveArtist(with artistId: String,
                               onComplete:@escaping (_ success: Bool, _ data: Data) -> Void) {
        let url: URL = URL(string: Endpoints.spotifyArtists + "/" + artistId)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        AsyncWebService.shared.sendAsyncRequest(request: request) { (status, responseData) in
            onComplete(status == 200, responseData)
        }
    }
    static func retrieveArtists(with ids: String, onComplete:@escaping (_ success: Bool, _ data: Data) -> Void) {
        let url: URL = URL(string: Endpoints.spotifyArtists + "?ids=" + ids)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        AsyncWebService.shared.sendAsyncRequest(request: request) { (status, responseData) in
            onComplete(status == 200, responseData)
        }
    }
}
