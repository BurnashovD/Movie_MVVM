// FilmsViewModel.swift
// Copyright © DB. All rights reserved.

import UIKit

/// Вью модель экрана списка фильмов
final class FilmsViewModel: FilmsViewModelProtocol {
    // MARK: - Public properties

    var updateHandler: ((ViewData) -> Void)?
    var errorHandler: ((Error) -> Void)?
    var viewData: ViewData = .initial

    // MARK: - Private properties

    private let networkService: NetworkServicable
    private let imageService: ImageServicable
    private let coordinator: Coordinatable

    // MARK: - init

    init(networkService: NetworkServicable, imageService: ImageServicable, coordinator: Coordinatable) {
        updateHandler?(.initial)
        self.networkService = networkService
        self.coordinator = coordinator
        self.imageService = imageService
    }

    // MARK: - Public methods

    func fetchMovies(_ filter: NetworkService.ParameterType) {
        updateHandler?(.loading)
        networkService.fetchMovies(parameter: filter) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                self.viewData = .success(movies)
                self.updateHandler?(.success(movies))
            case let .failure(error):
                self.errorHandler?(error)
            }
        }
    }

    func moviesCount() -> Int {
        switch viewData {
        case .initial:
            return 0
        case .loading:
            return 1
        case let .success(movies):
            return movies.count
        case .failure:
            return 1
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
        coordinator.addDependency(movie: movie)
    }
}
