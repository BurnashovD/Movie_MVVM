// Actor.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

struct Actor: Decodable {
    let id: Int
    let originalName: String
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
}
