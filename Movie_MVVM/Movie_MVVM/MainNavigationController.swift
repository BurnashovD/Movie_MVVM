// MainNavigationController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Основной навигейшн
final class MainNavigationController: UINavigationController {
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
    }

    // MARK: - Private methods

    private func configNavigationBar() {
        navigationBar.prefersLargeTitles = true
        navigationBar
            .largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.barTintColor = UIColor(named: Constants.blueViewColorName)
        navigationBar.tintColor = UIColor.red
    }
}

/// Константы
private extension MainNavigationController {
    enum Constants {
        static let filmCellIdentifier = "film"
        static let filterCellIdentifier = "filter"
        static let blueViewColorName = "blueView"
        static let filmsText = "Фильмы"
    }
}
