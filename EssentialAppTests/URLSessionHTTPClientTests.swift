//
//  URLSessionHTTPClientTests.swift
//  EssentialAppTests
//
//  Created by temptempest on 31.01.2023.
//

import XCTest

class URLSessionHTTPClient {
    private let session: URLSession
    init(session: URLSession) {
        self.session = session
    }
    func get(from url: URL) {
        session.dataTask(with: url) { _, _, _ in }.resume()
    }
}
@available(iOS, deprecated: 13.0)
class URLSessionHTTPClientTests: XCTestCase {
    func test_getFromURL_resumesDataTaskWithURL() {
        let url = URL(string: "https://any-url.com")!
        let session = URLSessionSpy()
        let task = URLSessionDataTaskSpy()
        session.stub(url: url, task: task)
        let sut = URLSessionHTTPClient(session: session)
        sut.get(from: url)
        XCTAssertEqual(task.resumeCallCount, 1)
    }
}

// MARK: - Helpers
@available(iOS, deprecated: 13.0)
extension URLSessionHTTPClientTests {
    fileprivate class URLSessionSpy: URLSession {
        private var stubs = [URL: URLSessionDataTask]()
        func stub(url: URL, task: URLSessionDataTask) {
            stubs[url] = task
        }
        override func dataTask(with url: URL,
                               completionHandler:
                               @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            return stubs[url] ?? FakeURLSessionDataTask()
        }
    }
    fileprivate class FakeURLSessionDataTask: URLSessionDataTask {
        override func resume() {}
    }
    fileprivate class URLSessionDataTaskSpy: URLSessionDataTask {
        var resumeCallCount = 0
        override func resume() {
            resumeCallCount += 1
        }
    }
}
