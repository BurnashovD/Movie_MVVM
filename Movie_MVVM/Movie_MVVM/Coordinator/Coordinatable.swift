// Coordinatable.swift
// Copyright © DB. All rights reserved.

import UIKit

/// Протокол координатора
protocol Coordinatable: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinatable] { get set }
    var builder: BuilderProtocol { get set }
    func initial()
    func addDependency(movie: Movie)
    func childDidFinish(child: Coordinatable)
}
