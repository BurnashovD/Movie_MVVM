// FilmsViewModelProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол вью модель экрана списка фильмов
protocol FilmsViewModelProtocol {
    var updateHandler: ((ViewData) -> Void)? { get set }
    func fetchMovies(_ filter: NetworkService.ParameterType)
    func selectedRowAction(tableView: UITableView, selectedCell: IndexPath?)
}
