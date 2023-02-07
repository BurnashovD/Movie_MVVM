// ImageAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис получения изображений
final class ImageAPIService: ImageAPIServicable {
    // MARK: - Public methods

    func fetchImage(_ url: String, _ completion: @escaping (Result<Data, Error>) -> Void) {
        let imageURL = "\(Constants.filmCellImageURLString)\(url)"
        guard let url = URL(string: imageURL) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
        .resume()
    }
}

/// Константы
private extension ImageAPIService {
    enum Constants {
        static let filmCellImageURLString = "http://image.tmdb.org/t/p/w500"
    }
}
