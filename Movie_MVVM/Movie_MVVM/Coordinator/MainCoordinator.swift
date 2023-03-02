// MainCoordinator.swift
// Copyright © DB. All rights reserved.

import UIKit

/// Основной координатор
final class MainCoordintor: Coordinatable {
    // MARK: - Public properties

    var navigationController: UINavigationController
    var builder: BuilderProtocol
    var childCoordinators: [Coordinatable] = []

    // MARK: - init

    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }

    // MARK: - Public methods

    func initial() {
        let filmsVC = builder.makeFilmsModule(coordinator: self)
        navigationController.pushViewController(filmsVC, animated: true)
    }

    func addDependency(movie: Movie) {
        let child = SecondCoordinator(
            navigationController: navigationController,
            builder: builder,
            parentCoordinator: self,
            movie: movie
        )
        childCoordinators.append(child)
        child.initial()
    }

    func childDidFinish(child: Coordinatable) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
