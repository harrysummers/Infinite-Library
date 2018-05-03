//
//  SpotifyTests.swift
//  InfiniteLibraryTests
//
//  Created by Harry Summers on 5/2/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import XCTest
@testable import InfiniteLibrary

class SpotifyTests: XCTestCase {
    let albumId = "0sNOF9WDwhWunNAHPD3Baj"

    func getAlbumTests() {
        let expectation = XCTestExpectation()
        SpotifyNetworking.retrieveAlbum(with: albumId) { (status) in
            XCTAssert(status)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
}
