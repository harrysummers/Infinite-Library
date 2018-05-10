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
    
    func map(in context: NSManagedObjectContext) -> Album {
        let album = Album(context: context)
        album.setValue(name, forKey: "name")
        album.setValue(external_urls?.spotify, forKey: "external_url")
        if let images = images, images.count > 0 {
            album.setValue(images[0].url, forKey: "image_url")
        }
        if let artists = artists, artists.count > 0 {
            let artist = artists[0]
            album.artist = artist.map(in: context)
            //album.setValue(artist.map(in: context), forKey: "artist")
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
            newArtist.setValue(id, forKey: "id")
            newArtist.setValue(name, forKey: "name")
            newArtist.setValue(external_urls?.spotify, forKey: "external_url")
            return newArtist
        } else {
            return artist!
        }

    }
    
}

struct JSONExternalURLs: Decodable {
    var spotify: String?
}

struct JSONAlbumArt: Decodable {
    var height: Int
    var url: String
    var width: Int
    
}
