// ModulBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Сборщик модулей
final class ModulBuilder: BuilderProtocol {
    // MARK: - Public methods

    func makeFilmsModule(coordinator: Coordinatable) -> UITableViewController {
        let view = FilmsTableViewController()
        let networkService = NetworkService()
        let imageService = ImageService()
        let viewModel = FilmsViewModel(
            networkService: networkService,
            imageService: imageService,
            coordinator: coordinator
        )
        view.viewModel = viewModel
        return view
    }

    func makeFilmInfoModule(coordinator: SecondCoordinatorProtocol, movie: Movie) -> UITableViewController {
        let view = FilmInfoTableViewController()
        let networkService = NetworkService()
        let imageService = ImageService()
        let viewModel = FilmInfoViewModel(
            networkService: networkService,
            imageService: imageService,
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
