// NetworkServicable.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол сетевого сервиса
protocol NetworkServicable {
    func fetchMovies(
        parameter: NetworkService.ParameterType,
        _ completion: @escaping (Result<[Movie], Error>) -> Void
    )
    func fetchActors(id: String, _ completion: @escaping (Result<[Actor], Error>) -> Void)
    func fetchTrailers(id: String, _ completion: @escaping (Result<[Trailer], Error>) -> Void)
}
