// SecondCoordinator.swift
// Copyright © DB. All rights reserved.

import UIKit

/// Второй координатор
final class SecondCoordinator: SecondCoordinatorProtocol {
    // MARK: - Public properties

    var navigationController: UINavigationController
    var childCoordinators: [Coordinatable] = []
    var parentCoordinator: Coordinatable?
    var builder: BuilderProtocol
    var movie: Movie

    // MARK: - init

    init(
        navigationController: UINavigationController,
        builder: BuilderProtocol,
        parentCoordinator: Coordinatable,
        movie: Movie
    ) {
        self.navigationController = navigationController
        self.builder = builder
        self.movie = movie
        self.parentCoordinator = parentCoordinator
    }

    // MARK: - Public methods

    func initial() {
        let filmInfoVC = builder.makeFilmInfoModule(coordinator: self, movie: movie)
        navigationController.pushViewController(filmInfoVC, animated: true)
    }

    func didFinish() {
        parentCoordinator?.childDidFinish(child: self)
    }

    func openWeb(_ trailer: Trailer) {
        let webView = builder.makeTrailerWebViewModule(coordinator: self, trailer: trailer)
        navigationController.present(webView, animated: true)
    }

    func addDependency(movie: Movie) {}

    func childDidFinish(child: Coordinatable) {}
}
