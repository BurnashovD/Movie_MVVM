// TrailerResults.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ответ сервера с трейлерами
struct TrailerResults: Codable {
    /// Массив трейлеров
    let results: [Trailer]
}
