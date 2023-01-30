//
//  RemoteFeedLoaderTests.swift
//  EssentialAppTests
//
//  Created by temptempest on 30.01.2023.
//

import XCTest

class RemoteFeedLoader {}

class HTTPClient {
    var requestURL: URL?
}

final class RemoteFeedLoaderTests: XCTestCase {
    var sut: RemoteFeedLoader!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = RemoteFeedLoader()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_init_doesNotRequestDataFromURL() {
        _ = RemoteFeedLoader()
        let client = HTTPClient()
        XCTAssertNil(client.requestURL)
    }
}
