// Coordinatable.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол координатора
protocol Coordinatable: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinatable] { get set }
    var builder: BuilderProtocol { get set }
    func initial()
    func goForward(movie: Movie)
    func childDidFinish(child: Coordinatable)
}
