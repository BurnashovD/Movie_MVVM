// MockNetworkService.swift
// Copyright © DB. All rights reserved.

import Foundation
@testable import Movie_MVVM

/// Мок сетевого слоя
final class MockNetworkService: NetworkServicable {
    // MARK: - Public methods

    func fetchMovies(
        parameter: NetworkService.ParameterType,
        _ completion: @escaping (Result<[Movie], Error>) -> Void
    ) {
        guard
            let data = readLocalJSONFile(fileName: "MovieJSON"),
            let movies = MockParseService.parseMoviesData(data)
        else { return }
        completion(.success(movies))
    }

    func fetchActors(id: String, _ completion: @escaping (Result<[Actor], Error>) -> Void) {
        guard
            let data = readLocalJSONFile(fileName: "ActorJSON"),
            let actors = MockParseService.parseActorsData(data)
        else { return }
        completion(.success(actors))
    }

    func fetchTrailers(id: String, _ completion: @escaping (Result<[Trailer], Error>) -> Void) {
        guard
            let data = readLocalJSONFile(fileName: "TrailerJSON"),
            let trailers = ParceService.parseTrailersData(data)
        else { return }
        completion(.success(trailers))
    }

    // MARK: - Private methods

    private func readLocalJSONFile(fileName: String) -> Data? {
        do {
            guard let filePath = Bundle.main.path(forResource: fileName, ofType: "json") else { return nil }
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            return data
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

/// Константы
private extension MockNetworkService {
    enum Constants {
        static let jsonFileType = "json"
        static let movieJSONFileName = "MovieJSON"
        static let actorJSONFileName = "ActorJSON"
        static let trailerJSONFileName = "TrailerJSON"
    }
}
