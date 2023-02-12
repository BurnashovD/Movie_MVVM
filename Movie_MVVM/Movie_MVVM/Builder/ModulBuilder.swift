// ModulBuilder.swift
// Copyright © DB. All rights reserved.

import UIKit

/// Сборщик модулей
final class ModulBuilder: BuilderProtocol {
    // MARK: - Public methods

    func makeFilmsModule(coordinator: Coordinatable) -> UITableViewController {
        let view = FilmsTableViewController()
        let keyChainService = KeyChainService()
        let networkService = NetworkService(keyChainService: keyChainService)
        let imageService = ImageService()
        let coreDataService = CoreDataService()

        let viewModel = FilmsViewModel(
            networkService: networkService,
            imageService: imageService,
            coreDataService: coreDataService,
            keyChainService: keyChainService,
            coordinator: coordinator
        )
        view.viewModel = viewModel
        return view
    }

    func makeFilmInfoModule(coordinator: SecondCoordinatorProtocol, movie: Movie) -> UITableViewController {
        let view = FilmInfoTableViewController()
        let keyChainService = KeyChainService()
        let networkService = NetworkService(keyChainService: keyChainService)
        let imageService = ImageService()
        let coreDataService = CoreDataService()
        let viewModel = FilmInfoViewModel(
            networkService: networkService,
            imageService: imageService,
            coreDataService: coreDataService,
            movie: movie,
            coordinator: coordinator
        )
        view.viewModel = viewModel
        view.title = movie.title
        return view
    }

    func makeTrailerWebViewModule(coordinator: SecondCoordinatorProtocol, trailer: Trailer) -> UIViewController {
        let view = TrailerWebPageViewController()
        let viewModel = TrailerViewModel(trailer: trailer, coordinator: coordinator)
        view.viewModel = viewModel
        return view
    }
}
