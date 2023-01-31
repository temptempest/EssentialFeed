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
    var insertCallCount = 0
    
    func deleteCachedFeed() {
        deleteCachedFeedCount += 1
    }
    
    func completeDeletion(with error: Error, at index: Int = 0) {
         
    }
}

// MARK: - Helpers
final class CacheFeedUseCaseTests: XCTestCase {
    func test_init_doesNotDeleteCacheUponCreation() {
        let (_, store) = makeSUT()
        XCTAssertEqual(store.deleteCachedFeedCount, 0)
    }
    
    func test_save_requestsCacheDeletion() {
        let items = [uniqueItem(),uniqueItem()]
        let (sut, store) = makeSUT()
        sut.save(items)
        XCTAssertEqual(store.deleteCachedFeedCount, 1)
    }
    
    func test_save_doesNotRequestCacheInsertionOnDeleteError() {
        let items = [uniqueItem(),uniqueItem()]
        let (sut, store) = makeSUT()
        let deletionError = anyError()
        sut.save(items)
        store.completeDeletion(with: deletionError)
        XCTAssertEqual(store.insertCallCount, 0)
    }
}

// MARK: - Helpers
extension CacheFeedUseCaseTests {
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStore) {
        let store = FeedStore()
        let sut = LocalFeedLoader(store: store)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, store) 
    }
    
    private func uniqueItem() -> FeedItem {
        return FeedItem(id: UUID(), description: "any", location: "any", imageURL: anyURL())
    }
    private func anyURL() -> URL {
        return URL(string: "https://any-url.com")!
    }
    private func anyError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
}
