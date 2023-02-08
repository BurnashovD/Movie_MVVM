// TrailerResults.swift
// Copyright © DB. All rights reserved.

import Foundation

/// Ответ сервера с трейлерами
struct TrailerResults: Codable {
    /// Массив трейлеров
    let results: [Trailer]
}
