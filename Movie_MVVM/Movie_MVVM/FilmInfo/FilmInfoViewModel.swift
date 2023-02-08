// FilmInfoViewModel.swift
// Copyright © DB. All rights reserved.

import Foundation

/// Вью модель экрана с информацией о выбранном фильме
final class FilmInfoViewModel: FilmInfoViewModelProtocol {
    // MARK: - Public properties

    var movie: Movie?
    var trailers: [Trailer] = []
    var actors: [Actor] = []
    var updateHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?

    // MARK: - Private properties

    private var networkService: NetworkServicable
    private var imageService: ImageServicable
    private var coordinator: SecondCoordinatorProtocol

    // MARK: - init

    init(
        networkService: NetworkServicable,
        imageService: ImageServicable,
        movie: Movie?,
        coordinator: SecondCoordinatorProtocol
    ) {
        self.networkService = networkService
        self.movie = movie
        self.coordinator = coordinator
        self.imageService = imageService
    }

    // MARK: - Public methods

    func fetchActors() {
        guard let id = movie?.currentFilmId else { return }
        networkService.fetchActors(id: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(actors):
                self.actors = actors
                self.updateHandler?()
            case let .failure(error):
                self.errorHandler?(error)
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
                self.trailers = trailers
            case let .failure(error):
                self.errorHandler?(error)
            }
        }
    }
}
