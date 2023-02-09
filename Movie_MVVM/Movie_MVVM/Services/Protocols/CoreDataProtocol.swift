// CoreDataProtocol.swift
// Copyright © DB. All rights reserved.

import Foundation

protocol CoreDataProtocol {
    associatedtype Object
    func saveMovies(_ movies: [Object])
    func getMovies(parameter: NetworkService.ParameterType) -> [Object]?
}
