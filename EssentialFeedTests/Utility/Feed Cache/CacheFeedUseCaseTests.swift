//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by temptempest on 30.01.2023.
//

import XCTest
import EssentialFeed

class LocalFeedLoader {
    private let store: FeedStore
    init(store: FeedStore) {
        self.store = store
    }
    
    func save(_ items: [FeedItem]) {
        store.deleteCachedFeed()
    }
}
class FeedStore {
    var deleteCachedFeedCount = 0
    
    func deleteCachedFeed() {
        deleteCachedFeedCount += 1
    }
}

// MARK: - Helpers
final class CacheFeedUseCaseTests: XCTestCase {
    func test_init_doesNotDeleteCacheUponCreation() {
        let store = FeedStore()
        _ = LocalFeedLoader(store: store)
        XCTAssertEqual(store.deleteCachedFeedCount, 0)
    }
    
    func test_save_requestsCacheDeletion() {
        let store = FeedStore()
        let sut = LocalFeedLoader(store: store)
        let items = [uniqueItem(),uniqueItem()]
        sut.save(items)
        XCTAssertEqual(store.deleteCachedFeedCount, 1)
    }
}

extension CacheFeedUseCaseTests {
    private func uniqueItem() -> FeedItem {
        return FeedItem(id: UUID(), description: "any", location: "any", imageURL: anyURL())
    }
    private func anyURL() -> URL {
        return URL(string: "https://any-url.com")!
    }
}
