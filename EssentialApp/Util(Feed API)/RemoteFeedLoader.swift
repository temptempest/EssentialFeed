//
//  RemoteFeedLoader.swift
//  EssentialApp
//
//  Created by temptempest on 30.01.2023.
//

import Foundation

// typealias LoadFeedResult = Result<[FeedItem], Error>

public protocol HTTPClient {
    func get(from url: URL)
}

public struct RemoteFeedLoader {
    private let url: URL
    private let client: HTTPClient
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    public  func load() {
        client.get(from: url)
    }
}
