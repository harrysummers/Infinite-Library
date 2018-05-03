//
//  Infinite_LibraryTests.swift
//  Infinite LibraryTests
//
//  Created by Harry Summers on 5/2/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import XCTest
@testable import InfiniteLibrary


class Infinite_LibraryTests: XCTestCase {
    let albumId = "4Db5w1mFaolDotknFJiteD"


    func testAll() {
        let expectation = XCTestExpectation()

        AsyncWebService.shared.getAccessToken { (_, _) in
            //self.getAlbumTest()
            self.getLibraryAlbums()
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 100.0)
    }
    
    func getAlbumTest() {
        let expectation = XCTestExpectation()
        AlbumDownloader().download(albumId) { (album) in
            print(album.name ?? "Could not print album")
            XCTAssert(album.name != nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func getLibraryAlbums() {
        let expectation = XCTestExpectation()
        LibraryDownloader().download { (library) in
            if let items = library.items {
                XCTAssert(items.count > 0)
            } else {
                XCTAssert(false)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
    }
    
    func convertAlbumJSONTest() {
                
    }

}
