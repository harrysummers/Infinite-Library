//
//  SpotifyModels.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/3/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation

struct JSONLibrary: Decodable {
    var href: String?
    var items: [JSONLibraryAlbum]?
}

struct JSONLibraryAlbum: Decodable {
    var added_ad: String?
    var album: JSONAlbum?
}


struct JSONAlbum: Decodable {
    var album_type: String?
    var artists: [JSONArtist]?
    var external_urls: JSONExternalURLs?
    //var genres:
    var href: String?
    var id: String?
    var images: [JSONAlbumArt]?
    var label: String?
    var name: String?
    var release_date: String?
    var release_date_precision: String?
    var type: String?
    var uri: String?
}

struct JSONArtist: Decodable {
    var external_urls: JSONExternalURLs?
    var href: String?
    var id: String?
    var name: String?
    var type: String?
    var uri: String?
}

struct JSONExternalURLs: Decodable {
    var spotify: String?
}

struct JSONAlbumArt: Decodable {
    var height: Int
    var url: String
    var width: Int
}
