//
//  RemoteFeedLoaderTests.swift
//  EssentialAppTests
//
//  Created by temptempest on 30.01.2023.
//

import XCTest

class RemoteFeedLoader {
    let client: HTTPClient
    let url: URL
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    func load() {
        HTTPClient.shared.get(from: url)
    }
}

class HTTPClient {
    static var shared = HTTPClient()
    func get(from url: URL) {}
}

class HTTPClientSpy: HTTPClient {
    var requestURL: URL?
    override func get(from url: URL) {
         requestURL = url
    }
}

final class RemoteFeedLoaderTests: XCTestCase {
    var sut: RemoteFeedLoader!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = nil
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_init_doesNotRequestDataFromURL() {
        let url = URL(string: "https://a-given-url.com ")!
        let client = HTTPClientSpy()
        _ = RemoteFeedLoader(url: url, client: client)
        HTTPClient.shared = client
        XCTAssertNil(client.requestURL)
    }

    func test_load_requestDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        sut = RemoteFeedLoader(url: url, client: client)
        sut.load()
        XCTAssertEqual(client.requestURL, url)
    }
}
