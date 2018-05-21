//
//  BaseUrl.swift
//  Infinite Library
//
//  Created by Harry Summers on 5/2/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation

class Endpoints {
    static let baseUrl = "https://api.spotify.com/v1/"
    static let spotifyAlbums = Endpoints.baseUrl + "albums/"
    static let spotifyLibraryAlbums = Endpoints.baseUrl + "me/albums"
    static let spotifyArtists = Endpoints.baseUrl + "artists"
}
