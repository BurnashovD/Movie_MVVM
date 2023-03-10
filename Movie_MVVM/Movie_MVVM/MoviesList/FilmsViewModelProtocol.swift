// FilmsViewModelProtocol.swift
// Copyright © DB. All rights reserved.

import UIKit

/// Протокол вью модель экрана списка фильмов
protocol FilmsViewModelProtocol {
    var updateHandler: ((ViewData) -> Void)? { get set }
    var errorHandler: ((Error) -> Void)? { get set }
    var viewData: ViewData { get set }
    func fetchMovies(_ filter: NetworkService.ParameterType)
    func loadMovies(_ filter: NetworkService.ParameterType)
    func moviesCount() -> Int
    func selectedRowAction(tableView: UITableView, selectedCell: IndexPath?)
    func apiKeyCheckAction(_ completion: () -> Void, filter: NetworkService.ParameterType)
    func saveApiKeyAction(_ key: String, filter: NetworkService.ParameterType)
}
