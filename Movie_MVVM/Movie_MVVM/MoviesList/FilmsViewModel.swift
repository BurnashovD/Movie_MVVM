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
    private let coreDataService: CoreDataServiceProtocol
    private let keyChainService: KeyChainServiceProtocol

    // MARK: - init

    init(
        networkService: NetworkServicable,
        imageService: ImageServicable,
        coreDataService: CoreDataServiceProtocol,
        keyChainService: KeyChainServiceProtocol,
        coordinator: Coordinatable
    ) {
        updateHandler?(.initial)
        self.networkService = networkService
        self.coordinator = coordinator
        self.imageService = imageService
        self.coreDataService = coreDataService
        self.keyChainService = keyChainService
    }

    // MARK: - Public methods

    func fetchMovies(_ filter: NetworkService.ParameterType) {
        updateHandler?(.loading)
        networkService.fetchMovies(parameter: filter) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                movies.forEach { film in
                    switch filter {
                    case .popular:
                        film.filter = Constants.popularFilmsFilter
                    case .topRated:
                        film.filter = Constants.topRatedFilmsFilter
                    case .upcoming:
                        film.filter = Constants.upcomingFilmsFilter
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

    func saveApiKeyAction(_ key: String, filter: NetworkService.ParameterType) {
        UserDefaults.standard.set(true, forKey: Constants.getApiKetValue)
        keyChainService.save(key, forKey: Constants.getApiKetValue)
        fetchMovies(filter)
    }

    func apiKeyCheckAction(_ completion: () -> Void, filter: NetworkService.ParameterType) {
        if UserDefaults.standard.bool(forKey: Constants.getApiKetValue) == false {
            completion()
        } else {
            fetchMovies(filter)
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

/// Константы
private extension FilmsViewModel {
    enum Constants {
        static let topRatedFilmsFilter = "topRated"
        static let upcomingFilmsFilter = "upcoming"
        static let popularFilmsFilter = "popular"
        static let getApiKetValue = "key"
    }
}
