// NetworkService.swift
// Copyright © DB. All rights reserved.

import Foundation

/// Сетевой сервис
struct NetworkService: NetworkServicable {
    // MARK: - Public methods

    func fetchMovies(parameter: ParameterType, _ completion: @escaping (Result<[Movie], Error>) -> Void) {
        let session = URLSession.shared
        guard let url =
            URL(
                string: "\(Constants.baseURL)\(parameter.path)\(Constants.filmsListAPIKey)"
            )
        else { return }
        session.dataTask(with: URLRequest(url: url)) { data, _, error in
            do {
                guard let data = data, let movies = ParceService.parseMoviesData(data) else {
                    guard let error = error else { return }
                    completion(.failure(error))
                    return
                }
                DispatchQueue.main.async {
                    completion(.success(movies))
                }
            }
        }
        .resume()
    }

    func fetchActors(id: String, _ completion: @escaping (Result<[Actor], Error>) -> Void) {
        guard
            let url = URL(string: "\(Constants.moviesStartURLString)\(id)\(Constants.actorsEndURLString)")
        else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            do {
                guard let data = data, let actors = ParceService.parseActorsData(data) else {
                    guard let error = error else { return }
                    completion(.failure(error))
                    return
                }
                DispatchQueue.main.async {
                    completion(.success(actors))
                }
            }
        }
        .resume()
    }

    func fetchTrailers(id: String, _ completion: @escaping (Result<[Trailer], Error>) -> Void) {
        guard
            let url = URL(string: "\(Constants.moviesStartURLString)\(id)\(Constants.trailerEndURLString)")
        else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            do {
                guard let data = data, let trailers = ParceService.parseTrailersData(data) else {
                    guard let error = error else { return }
                    completion(.failure(error))
                    return
                }
                DispatchQueue.main.async {
                    completion(.success(trailers))
                }
            }
        }
        .resume()
    }
}

/// Константы и типы параметров
extension NetworkService {
    enum Constants {
        static let baseURL = "https://api.themoviedb.org/3/movie/"
        static let topRatedParameterName = "top_rated"
        static let upcomingParameterName = "upcoming"
        static let popularParameterName = "popular"
        static let apiKeyText = "api_key"
        static let apiKeyValue = "56c45ba32cd76399770966658bf65ca0"
        static let languageText = "language"
        static let languageValue = "ru-RU&page=1"
        static let moviesStartURLString = "https://api.themoviedb.org/3/movie/"
        static let actorsEndURLString = "/credits?api_key=56c45ba32cd76399770966658bf65ca0&language=en-US"
        static let trailerEndURLString = "/videos?api_key=56c45ba32cd76399770966658bf65ca0&language=ru-RU"
        static let filmCellImageURLString = "http://image.tmdb.org/t/p/w500"
        static let filmsListAPIKey = "?api_key=56c45ba32cd76399770966658bf65ca0&language=ru-RU&page=1"
    }

    enum ParameterType {
        case topRated
        case upcoming
        case popular

        var path: String {
            switch self {
            case .popular:
                return Constants.popularParameterName
            case .topRated:
                return Constants.topRatedParameterName
            case .upcoming:
                return Constants.upcomingParameterName
            }
        }
    }
}
