// ParceServicable.swift
// Copyright © DB. All rights reserved.

import Foundation

/// Протокол парсинг сервиса
protocol ParseServicable {
    static func parseMoviesData(_ data: Data) -> [Movie]?
    static func parseActorsData(_ data: Data) -> [Actor]?
    static func parseTrailersData(_ data: Data) -> [Trailer]?
}
