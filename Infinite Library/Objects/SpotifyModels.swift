//
//  SpotifyModels.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/3/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation
import CoreData

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
    var href: String?
    var id: String?
    var images: [JSONAlbumArt]?
    var label: String?
    var name: String?
    var release_date: String?
    var release_date_precision: String?
    var type: String?
    var uri: String?
    
    func map(in context: NSManagedObjectContext) -> Album {
        let album = Album(context: context)
        album.name = name
        album.external_url = external_urls?.spotify
        
        if let images = images, images.count > 0 {
            album.image_url = images[0].url
        }
        if let artists = artists, artists.count > 0 {
            let jsonArtist = artists[0]
            
            let artist = jsonArtist.map(in: context)
            artist.addToAlbums(album)
        }
        return album
    }
    
}

struct JSONArtist: Decodable {
    var external_urls: JSONExternalURLs?
    var href: String?
    var id: String?
    var name: String?
    var type: String?
    var uri: String?

    func map(in context: NSManagedObjectContext) -> Artist {
        let artist = Artist.getArtist(with: id ?? "", in: context)
        
        if artist == nil {
            let newArtist = Artist(context: context)
            newArtist.id = id
            newArtist.name = name
            newArtist.external_url = external_urls?.spotify
            return newArtist
        } else {
            return artist!
        }

    }
    
}

struct JSONSpotifyArtist: Decodable {
    var images: [JSONArtistArt]?
    var id: String = ""
}

struct JSONArtistArt: Decodable {
    var height: Int
    var url: String
    var width: Int
}

struct JSONExternalURLs: Decodable {
    var spotify: String?
}

struct JSONAlbumArt: Decodable {
    var height: Int
    var url: String
    var width: Int
    
}

struct JSONArtists: Decodable {
    var artists: [JSONSpotifyArtist]
}
