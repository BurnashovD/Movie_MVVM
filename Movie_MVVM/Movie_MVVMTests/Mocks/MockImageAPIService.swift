// MockImageAPIService.swift
// Copyright © DB. All rights reserved.

@testable import Movie_MVVM
import UIKit

/// Мок сервиса получения данных изображений
final class MockImageAPIService: ImageAPIServicable {
    // MARK: - Public methods

    func fetchImage(_ url: String, _ completion: @escaping (Result<Data, Error>) -> Void) {
        guard let data = UIImage(systemName: Constants.noteImageName)?.pngData() else {
            let error = NSError(domain: Constants.errorDomainValue, code: Constants.errorCodeValue)
            completion(.failure(error))
            return
        }
        completion(.success(data))
    }
}

/// Константы
private extension MockImageAPIService {
    enum Constants {
        static let noteImageName = "note"
        static let errorDomainValue = "0"
        static let errorCodeValue = 1
    }
}
