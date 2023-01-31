//
//  URLSessionHTTPClientTests.swift
//  EssentialAppTests
//
//  Created by temptempest on 31.01.2023.
//

import XCTest
import EssentialApp

final class URLSessionHTTPClient {
    private let session: URLSession
    init(session: URLSession = .shared ) {
        self.session = session
    }
    func get(from url: URL, completion: @escaping  (HTTPClientResult) -> Void ) {
        session.dataTask(with: url) { _, _, error in
            if let error {
                completion(.failure(error))
            }
        }.resume()
    }
}

final class URLSessionHTTPClientTests: XCTestCase {
    func test_getFromURL_failsOnRequestError() {
        URLProtocolStub.startInterceptingRequest()
        let url = URL(string: "https://any-url.com")!
        let error = NSError(domain: "any error", code: 1)
        URLProtocolStub.stub(data: nil, response: nil, error: error)
        let sut = URLSessionHTTPClient()
        let exp = expectation(description: "Wait for completion")
        sut.get(from: url) { result in
            switch result {
            case .failure(let receivedError as NSError):
                let receivedErrorWithoutUserInfo = NSError(domain: receivedError.domain, code: receivedError.code)
                XCTAssertEqual(receivedErrorWithoutUserInfo, error)
            default:
                XCTFail("Expected failure with error: \(error), got \(result) instead")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
        URLProtocolStub.stopInterceptingRequest()
    }
}

// MARK: - Helpers
extension URLSessionHTTPClientTests {
    private struct Stub {
        let data: Data?
        let response: URLResponse?
        let error: Error?
    }
    private final class URLProtocolStub: URLProtocol {
        private static var stub:  Stub?
        static func stub(data: Data?, response: URLResponse?, error: Error?) {
            stub = Stub(data: data, response: response, error: error )
        }
        static func startInterceptingRequest() {
            URLProtocol.registerClass(URLProtocolStub.self)
        }
        static func stopInterceptingRequest() {
            URLProtocol.unregisterClass(URLProtocolStub.self)
            stub = nil
        }
        override class func canInit(with request: URLRequest) -> Bool {
            true
        }
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }
        override func startLoading() {
            if let data = URLProtocolStub.stub?.data {
                client?.urlProtocol(self, didLoad: data)
            }
            if let response = URLProtocolStub.stub?.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let error = URLProtocolStub.stub?.error {
                client?.urlProtocol(self, didFailWithError: error)
            }
            client?.urlProtocolDidFinishLoading(self)
        }
        override func stopLoading() {}
    }
}
