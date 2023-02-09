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

    private let coreDataService = CoreDataService()

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
                movies.forEach { film in
                    if filter == .upcoming {
                        film.filter = "upcoming"
                    } else if filter == .topRated {
                        film.filter = "topRated"
                    } else if filter == .popular {
                        film.filter = "popular"
                    }
                }
                self.viewData = .success(movies)
                self.updateHandler?(.success(movies))
                self.coreDataService.saveMovies(movies)
            case let .failure(error):
                self.errorHandler?(error)
            }
        }
    }

    func loadMovies(_ filter: NetworkService.ParameterType) {
        guard let coreMovies = coreDataService.getMovies(parameter: filter), !coreMovies.isEmpty else {
            fetchMovies(filter)
            return
        }
        viewData = .success(coreMovies)
        updateHandler?(.success(coreMovies))
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
