//
//  SpotifyModels.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/3/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation

struct Library: Decodable {
    var href: String?
    var items: [LibraryAlbum]?
}

struct LibraryAlbum: Decodable {
    var added_ad: String?
    var album: Album?
}


struct Album: Decodable {
    var album_type: String?
    var artists: [Artist]?
    var external_urls: ExternalURLs?
    //var genres:
    var href: String?
    var id: String?
    var images: [AlbumArt]?
    var label: String?
    var name: String?
    var release_date: String?
    var release_date_precision: String?
    var type: String?
    var uri: String?
}

struct Artist: Decodable {
    var external_urls: ExternalURLs?
    var href: String?
    var id: String?
    var name: String?
    var type: String?
    var uri: String?
}

struct ExternalURLs: Decodable {
    var spotify: String?
}

struct AlbumArt: Decodable {
    var height: Int
    var url: String
    var width: Int
}
