// FilmsViewModel.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью модель экрана списка фильмов
final class FilmsViewModel: FilmsViewModelProtocol {
    // MARK: - Private properties

    private let networkService: NetworkServicable
    private let coordinator: Coordinatable

    // MARK: - Public properties

    var updateHandler: ((ViewData) -> Void)?

    // MARK: - init

    init(networkService: NetworkServicable, coordinator: Coordinatable) {
        updateHandler?(.initial)
        self.networkService = networkService
        self.coordinator = coordinator
    }

    // MARK: - Public methods

    func fetchMovies(_ filter: NetworkService.ParameterType) {
        updateHandler?(.loading)
        networkService.fetchMovies(parameter: filter) { [weak self] result in
            switch result {
            case let .success(movies):
                self?.updateHandler?(.success(movies))
            case let .failure(error):
                self?.updateHandler?(.failure(error))
                print(error.localizedDescription)
            }
        }
    }

    func selectedRowAction(tableView: UITableView, selectedCell: IndexPath?) {
        let selectedCell = tableView.indexPathForSelectedRow
        guard
            let selectedCell = selectedCell,
            let cell = tableView.cellForRow(at: selectedCell) as? FilmTableViewCell
        else { return }
        cell.createCurrentMovie()
        guard let movie = cell.movie else { return }
        coordinator.goForward(movie: movie)
    }
}
