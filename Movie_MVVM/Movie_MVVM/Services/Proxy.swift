// Proxy.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис кешировнаия изображений
struct Proxy: ProxyProtocol {
    // MARK: - Private properties

    private let imageAPIService = ImageAPIService()

    // MARK: - Public properties

    var cache = NSCache<NSString, NSData>()

    // MARK: - Public methods

    func loadFromCache(posterPath: String, _ completion: @escaping (Data) -> Void) {
        guard let cacheData = cache.object(forKey: NSString(string: posterPath)) else {
            fetchImageData(posterPath: posterPath) { nsData in
                self.cache.setObject(nsData, forKey: NSString(string: posterPath))
                let data = Data(referencing: nsData)
                completion(data)
            }
            return
        }
        let imageData = Data(referencing: cacheData)
        completion(imageData)
    }

    private func fetchImageData(posterPath: String, _ completion: @escaping (NSData) -> Void) {
        imageAPIService.fetchImage(posterPath) { result in
            switch result {
            case let .success(data):
                let nsData = NSData(data: data)
                completion(nsData)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
