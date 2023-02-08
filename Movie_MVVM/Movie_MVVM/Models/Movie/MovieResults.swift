// MovieResults.swift
// Copyright © DB. All rights reserved.

import Foundation

/// Ответ сервера с фильмами
struct MovieResults: Decodable {
    /// Массив фильмов
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case results
    }
}
