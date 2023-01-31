//
//  XCTestCase+MemoryLeakTracking.swift
//  EssentialAppTests
//
//  Created by temptempest on 30.01.2023.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath,
                             line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance,
                         "Instance should have been deallocated. Potentional memory leak.", file: file, line: line)
        }
    }
}
