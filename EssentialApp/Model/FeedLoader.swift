//
//  FeedLoader.swift
//  EssentialApp
//
//  Created by temptempest on 30.01.2023.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedItem])
    case failure(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
