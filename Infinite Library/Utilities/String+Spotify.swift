//
//  String+Spotify.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 5/12/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation

extension String {
    func getAlbumId() -> String? {
        let url = self
        let base = Constants.baseUrlNewAlbum
        let start = base.count
        if url.contains(base) && url.count > start {
            let startIndex = url.index(url.startIndex, offsetBy: start)
            let substring = url[startIndex...]
            var idString = ""
            for letter in substring {
                if letter == "?" {
                    return idString
                } else {
                    idString.append(letter)
                }
            }
            return idString
        }
        return nil
    }
    func getAlbumExternalUrl() -> String? {
        let url = self
        var externalUrl = ""
        for letter in url {
            if letter == "?" {
                return externalUrl
            } else {
                externalUrl.append(letter)
            }
        }
        return externalUrl
    }
}
