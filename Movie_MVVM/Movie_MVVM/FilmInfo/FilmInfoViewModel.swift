// FilmInfoViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Вью модель экрана с информацией о выбранном фильме
final class FilmInfoViewModel: FilmInfoViewModelProtocol {
    // MARK: - Private properties

    private var networkService: NetworkServicable
    private var coordinator: SecondCoordinatorProtocol

    // MARK: - Public properties

    var updateActorsHandler: (([Actor]) -> Void)?
    var updateTrailersHandler: (([Trailer]) -> Void)?
    var movie: Movie?

    // MARK: - init

    init(networkService: NetworkServicable, movie: Movie?, coordinator: SecondCoordinatorProtocol) {
        self.networkService = networkService
        self.movie = movie
        self.coordinator = coordinator
    }

    // MARK: - Public methods

    func fetchActors() {
        guard let id = movie?.currentFilmId else { return }
        networkService.fetchActors(id: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(actors):
                self.updateActorsHandler?(actors)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    func viewDidDisapeardAction() {
        coordinator.didFinish()
    }

    func openTrailerWebViewAction(_ trailer: Trailer) {
        coordinator.openWeb(trailer)
    }

    func fetchTrailers() {
        guard let id = movie?.currentFilmId else { return }
        networkService.fetchTrailers(id: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(trailers):
                self.updateTrailersHandler?(trailers)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
