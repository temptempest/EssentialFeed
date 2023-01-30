//
//  HTTPClient.swift
//  EssentialApp
//
//  Created by temptempest on 30.01.2023.
//

import Foundation

public typealias HTTPClientResult = Result<(Data, HTTPURLResponse), Error>

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
