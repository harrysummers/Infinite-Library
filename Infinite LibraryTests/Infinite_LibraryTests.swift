//
//  Infinite_LibraryTests.swift
//  Infinite LibraryTests
//
//  Created by Harry Summers on 5/2/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import XCTest
@testable import InfiniteLibrary


class InfiniteLibraryTests: XCTestCase {
    let albumId = "4Db5w1mFaolDotknFJiteD"
    var library: JSONLibrary?
    let albumUrl = "https://open.spotify.com/track/6UPWfwnMVop0szGZacqwRn?si=Bt8ZIObiQ8OBPCLDkOQY9A"
    let albumUrlId = "6UPWfwnMVop0szGZacqwRn"
    
    func testAll() {
//        let expectation = XCTestExpectation()
//
//        AsyncWebService.shared.getAccessToken { (_, _) in
//            self.getAlbumTest()
//            self.getLibraryAlbums()
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 100.0)
        XCTAssert(albumUrl.getAlbumId() ?? "" == albumUrlId)
    }
    
    func getAlbumTest() {
//        let expectation = XCTestExpectation()
//        AlbumDownloader().download(albumId) { (album) in
//            print(album.name ?? "Could not print album")
//            XCTAssert(album.name != nil)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 10.0)
    }
    
    func getLibraryAlbums() {
        let expectation = XCTestExpectation()
        LibraryDownloader().download { (library) in
            self.library = library
            if let items = library.items {
                XCTAssert(items.count > 0)
            } else {
                XCTAssert(false)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1000.0)
    }
    
    
    
    
}
