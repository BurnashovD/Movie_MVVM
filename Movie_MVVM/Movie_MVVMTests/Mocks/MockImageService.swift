// MockImageService.swift
// Copyright © DB. All rights reserved.

@testable import Movie_MVVM
import UIKit

/// Мок сервиса обработки данных изображений
final class MockImageService: ImageServicable {
    // MARK: - Private properties

    private var imageAPIService = MockImageAPIService()

    // MARK: - Public methods

    func fetchImage(_ url: String, _ completion: @escaping ((Result<Data, Error>) -> Void)) {
        imageAPIService.fetchImage("") { result in
            switch result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
