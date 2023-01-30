//
//  RemoteFeedLoaderTests.swift
//  EssentialAppTests
//
//  Created by temptempest on 30.01.2023.
//

import XCTest

class RemoteFeedLoader {
    func load() {
        HTTPClient.shared.requestURL = URL(string: "https://a-url.com  ")
    }
}

class HTTPClient {
    static let shared = HTTPClient()
    private init() {}
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
        let client = HTTPClient.shared
        XCTAssertNil(client.requestURL)
    }

    func test_load_requestDataFromURL() {
        let client = HTTPClient.shared
        sut.load()
        XCTAssertNil(client.requestURL)
    }
}
