// SecondCoordinatorProtocol.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол второго координатора
protocol SecondCoordinatorProtocol: Coordinatable {
    var parentCoordinator: Coordinatable? { get set }
    var builder: BuilderProtocol { get set }
    var movie: Movie { get set }
    func didFinish()
    func goForward(movie: Movie)
    func openWeb(_ trailer: Trailer)
}
