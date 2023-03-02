// CoreDataProtocol.swift
// Copyright © DB. All rights reserved.

import Foundation

/// Протокол сервиса сохранения данных в базу данных
protocol CoreDataServiceProtocol {
    func saveMovies(_ movies: [Movie])
    func getMovies(parameter: NetworkService.ParameterType) -> [Movie]?
    func getActors(_ id: Int) -> [Actor]?
    func saveActors(_ actors: [Actor], id: Int)
}
