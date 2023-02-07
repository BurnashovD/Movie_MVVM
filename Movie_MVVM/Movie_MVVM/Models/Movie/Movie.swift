// Movie.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

struct Movie: Decodable {
    let backdropPath: String
    let id: Int
    let overview: String
    let posterPath, title: String
    let voteAverage: Double
    var filmImage: UIImage
    let currentFilmId: String

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case overview
        case posterPath = "poster_path"
        case title
        case voteAverage = "vote_average"
        case currentFilmId
        case filmImage
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
        id = try container.decode(Int.self, forKey: .id)
        overview = try container.decode(String.self, forKey: .overview)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        title = try container.decode(String.self, forKey: .title)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        currentFilmId = ""
        filmImage = UIImage()
    }

    init?(
        backdropPath: String,
        id: Int,
        overview: String,
        posterPath: String,
        title: String,
        voteAverage: Double,
        filmImage: UIImage,
        currentFilmId: String
    ) {
        self.backdropPath = backdropPath
        self.id = id
        self.overview = overview
        self.posterPath = posterPath
        self.title = title
        self.voteAverage = voteAverage
        self.filmImage = filmImage
        self.currentFilmId = currentFilmId
    }
}
