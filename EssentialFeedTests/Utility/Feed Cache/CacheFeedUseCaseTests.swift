//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by temptempest on 30.01.2023.
//

import XCTest

class LocalFeedLoader {
    init(store: FeedStore) {
        
    }
}
class FeedStore {
    var deleteCachedFeedCount = 0
}

final class CacheFeedUseCaseTests: XCTestCase {

    func test_init_doesNotDeleteCacheUponCreation() {
        let store = FeedStore()
        _ = LocalFeedLoader(store: store)
        XCTAssertEqual(store.deleteCachedFeedCount, 0)
    }
}
