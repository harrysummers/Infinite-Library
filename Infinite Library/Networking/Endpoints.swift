//
//  BaseUrl.swift
//  Infinite Library
//
//  Created by Harry Summers on 5/2/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation

class Endpoints {
    static let BASE_URL = "https://api.spotify.com/v1/"
    
    static let SPOTIFY_ALBUMS = Endpoints.BASE_URL + "albums/"
    static let SPOTIFY_LIBRARY_ALBUMS = Endpoints.BASE_URL + "me/albums"
    static let SPOTIFY_ARTIST = Endpoints.BASE_URL + "artists"
}
