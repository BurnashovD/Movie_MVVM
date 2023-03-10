// ActorResults.swift
// Copyright © DB. All rights reserved.

import Foundation

/// Ответ сервера с актерами
struct ActorsResults: Decodable {
    /// Массив актеров
    let cast: [Actor]
}
