// Actor.swift
// Copyright © DB. All rights reserved.

import Foundation

/// Актер
struct Actor: Decodable {
    /// Идентификатор
    let id: Int
    /// Имя
    let originalName: String
    /// Фото
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case originalName = "original_name"
        case profilePath = "profile_path"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        originalName = try container.decode(String.self, forKey: .originalName)
        profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath)
    }

    init(id: Int, originalName: String, profilePath: String?) {
        self.id = id
        self.originalName = originalName
        self.profilePath = profilePath
    }
}
