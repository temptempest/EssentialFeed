//
//  FeedItem.swift
//  EssentialApp
//
//  Created by temptempest on 30.01.2023.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL
}
