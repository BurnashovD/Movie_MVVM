// ActorResults.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ответ сервера с актерами
struct ActorsResults: Decodable {
    /// Массив актеров
    let cast: [Actor]
}
