// ProxyProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Проктокол сервиса кеширования
protocol ProxyProtocol {
    var cache: NSCache<NSString, NSData> { get set }
    func loadFromCache(posterPath: String, _ completion: @escaping (Data) -> Void)
}
