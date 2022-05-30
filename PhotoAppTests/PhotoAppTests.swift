//
//  PhotoAppTests.swift
//  PhotoAppTests
//
//  Created by Michał Niemiec on 17/05/2022.
//

import XCTest
@testable import PhotoApp

class PhotoAppTests: XCTestCase {

    var sut: NetworkProvider!

    override func setUp() async throws {
        sut = MockNetworkService()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testThatFetchingPhotosWorking() async {
        let photos = await sut.fetchPhotos()
        XCTAssertFalse(photos.isEmpty)
    }

    func testThatFirstPhotoIDIsEqualOne() async throws {
        let photos = await sut.fetchPhotos()
        let item = try XCTUnwrap(photos.first)
        XCTAssertEqual(item.id, 1)
    }
}
