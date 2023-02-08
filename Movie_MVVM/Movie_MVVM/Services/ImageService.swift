// ImageService.swift
// Copyright © DB. All rights reserved.

import Foundation

/// Сервис обработки данных изображения
final class ImageService: ImageServicable {
    // MARK: - Private properties

    private let imageAPIService = ImageAPIService()
    private let proxy = Proxy()

    // MARK: - Public methods

    func fetchImage(_ url: String, _ completion: @escaping ((Data) -> Void)) {
        proxy.loadFromCache(posterPath: url) { data in
            completion(data)
        }
    }
}
