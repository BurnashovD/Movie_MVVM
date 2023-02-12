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
    private var coreDataService: CoreDataServiceProtocol

    // MARK: - init

    init(
        networkService: NetworkServicable,
        imageService: ImageServicable,
        coreDataService: CoreDataServiceProtocol,
        movie: Movie?,
        coordinator: SecondCoordinatorProtocol
    ) {
        self.networkService = networkService
        self.movie = movie
        self.coordinator = coordinator
        self.imageService = imageService
        self.coreDataService = coreDataService
    }

    // MARK: - Public methods

    func fetchActors() {
        guard
            let id = movie?.currentFilmId,
            let movieId = movie?.id
        else { return }
        networkService.fetchActors(id: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(actors):
                self.actors = actors
                self.coreDataService.saveActors(actors, id: movieId)
                self.updateHandler?()
            case let .failure(error):
                self.errorHandler?(error)
            }
        }
    }

    func loadActors() {
        guard
            let id = movie?.id,
            let coreActors = coreDataService.getActors(id),
            !coreActors.isEmpty
        else {
            fetchActors()
            return
        }
        actors = coreActors
        updateHandler?()
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
