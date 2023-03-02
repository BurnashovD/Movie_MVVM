// FilmInfoTableViewController.swift
// Copyright © DB. All rights reserved.

import UIKit

/// Вью с информацией о выбранном фильме
final class FilmInfoTableViewController: UITableViewController {
    // MARK: - Private properties

    private let cellTypes: [CellTypes] = [.images, .overview, .actors]

    // MARK: - Public properties

    var viewModel: FilmInfoViewModelProtocol?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        viewModel?.loadActors()
        viewModel?.fetchTrailers()
        bind()
    }

    // MARK: - Public methods

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.viewDidDisapeardAction()
    }

    // MARK: - Private methods

    private func configUI() {
        navigationController?.navigationBar.largeTitleTextAttributes =
            [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .bold)
            ]
        navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = UIColor(named: Constants.blueViewColorName)
        configCell()
    }

    private func bind() {
        viewModel?.updateHandler = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        viewModel?.errorHandler = { error in
            print(error.localizedDescription)
        }
    }

    private func configCell() {
        tableView.register(TrailerTableViewCell.self, forCellReuseIdentifier: Constants.trailerCellIdentifier)
        tableView.register(OverviewTableViewCell.self, forCellReuseIdentifier: Constants.overviewCellIdentifier)
        tableView.register(ActorsTableViewCell.self, forCellReuseIdentifier: Constants.actorsCellIdentifier)
    }
}

/// Константы и типы ячеек
extension FilmInfoTableViewController {
    enum Constants {
        static let blueViewColorName = "blueView"
        static let trailerCellIdentifier = "trailer"
        static let overviewCellIdentifier = "overview"
        static let actorsCellIdentifier = "actors"
        static let moviesStartURLString = "https://api.themoviedb.org/3/movie/"
        static let actorsEndURLString = "/credits?api_key=56c45ba32cd76399770966658bf65ca0&language=en-US"
        static let trailerEndURLString = "/videos?api_key=56c45ba32cd76399770966658bf65ca0&language=ru-RU"
    }

    enum CellTypes {
        case images
        case overview
        case actors
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension FilmInfoTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = cellTypes[indexPath.section]
        switch type {
        case .images:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: Constants.trailerCellIdentifier,
                    for: indexPath
                ) as? TrailerTableViewCell, let movie = viewModel?.movie
            else {
                let cell = UITableViewCell()
                cell.backgroundColor = UIColor(named: Constants.blueViewColorName)
                return cell
            }
            cell.configure(movie)

            cell.openWebHandler = { [weak self] in
                guard let self = self, self.viewModel?.trailers.first != nil,
                      let trailer = self.viewModel?.trailers[indexPath.section] else { return }

                self.viewModel?.openTrailerWebViewAction(trailer)
            }
            return cell

        case .overview:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: Constants.overviewCellIdentifier,
                    for: indexPath
                ) as? OverviewTableViewCell, let movie = viewModel?.movie
            else { return UITableViewCell() }
            cell.configure(movie: movie)

            return cell

        case .actors:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: Constants.actorsCellIdentifier,
                    for: indexPath
                ) as? ActorsTableViewCell, let vmActors = viewModel?.actors, !vmActors.isEmpty
            else { return UITableViewCell() }
            cell.configure(actors: vmActors)

            return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
