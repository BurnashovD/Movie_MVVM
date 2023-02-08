// ParceService.swift
// Copyright © DB. All rights reserved.

import Foundation

/// Парсинг сервис
struct ParceService: ParseServicable {
    // MARK: - Public methods

    static func parseMoviesData(_ data: Data) -> [Movie]? {
        do {
            let movies = try? JSONDecoder().decode(MovieResults.self, from: data).results
            return movies
        }
    }

    static func parseActorsData(_ data: Data) -> [Actor]? {
        do {
            let actors = try? JSONDecoder().decode(ActorsResults.self, from: data).cast
            return actors
        }
    }

    static func parseTrailersData(_ data: Data) -> [Trailer]? {
        do {
            let trailers = try? JSONDecoder().decode(TrailerResults.self, from: data).results
            return trailers
        }
    }
}
