// ModulBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class ModulBuilder: BuilderProtocol {
    func makeFilmsModule(coordinator: Coordinatable) -> UITableViewController {
        let view = FilmsTableViewController()
        let networkService = NetworkService()
        let viewModel = FilmsViewModel(networkService: networkService, coordinator: coordinator)
        view.viewModel = viewModel
        return view
    }

    func makeFilmInfoModule(coordinator: SecondCoordinatorProtocol, movie: Movie) -> UITableViewController {
        let view = FilmInfoTableViewController()
        let networkService = NetworkService()
        let viewModel = FilmInfoViewModel(networkService: networkService, movie: movie, coordinator: coordinator)
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
