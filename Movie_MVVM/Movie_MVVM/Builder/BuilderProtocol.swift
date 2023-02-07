// BuilderProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Сборщик модулей
protocol BuilderProtocol {
    func makeFilmsModule(coordinator: Coordinatable) -> UITableViewController
    func makeFilmInfoModule(coordinator: SecondCoordinatorProtocol, movie: Movie) -> UITableViewController
    func makeTrailerWebViewModule(coordinator: SecondCoordinatorProtocol, trailer: Trailer)
        -> UIViewController
}
