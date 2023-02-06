// FilmsTableViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Класс отвечает за показ таблицы с фильмами
final class FilmsTableViewController: UITableViewController {
    // MARK: - Public properties

    private var movies = [Result]()
    private var cellTypes: [CellTypes] = [.filters, .films]
    private var actualURL = Constants.topRatedFilmsURLString
    var sendOverviewText: (() -> Void)?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        configCells()
        reformMovies()
    }

    // MARK: - Private methods

    private func configNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Constants.filmsText
        navigationController?.navigationBar
            .largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor(named: Constants.blueViewColorName)
        navigationController?.navigationBar.tintColor = UIColor.red
        view.backgroundColor = UIColor(named: Constants.blueViewColorName)
    }

    private func configCells() {
        tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: Constants.filmCellIdentifier)
        tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: Constants.filterCellIdentifier)
        tableView.showsVerticalScrollIndicator = false
    }

    private func reformMovies() {
        let session = URLSession.shared

        guard let url = URL(string: actualURL) else { return }
        session.dataTask(with: URLRequest(url: url)) { data, _, error in

            do {
                guard let newData = data else { return }
                let result = try JSONDecoder().decode(MovieResult.self, from: newData)
                DispatchQueue.main.async {
                    self.movies = result.results
                    self.tableView.reloadData()
                }
            } catch {
                print(Constants.errorText, error)
            }
        }.resume()
    }
}

/// Constants and CellTypes
extension FilmsTableViewController {
    enum Constants {
        static let topRatedFilmsURLString =
            "https://api.themoviedb.org/3/movie/top_rated?api_key=56c45ba32cd76399770966658bf65ca0&language=ru-RU&page=1"
        static let upcomingFilmsURLString =
            "https://api.themoviedb.org/3/movie/upcoming?api_key=56c45ba32cd76399770966658bf65ca0&language=ru-RU&page=1"
        static let popularFilmsURLString =
            "https://api.themoviedb.org/3/movie/popular?api_key=56c45ba32cd76399770966658bf65ca0&language=ru-Ru&page=1"
        static let filmCellIdentifier = "film"
        static let filterCellIdentifier = "filter"
        static let blueViewColorName = "blueView"
        static let filmsText = "Фильмы"
        static let errorText = "Error: "
    }

    enum CellTypes {
        case filters
        case films
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension FilmsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let type = cellTypes[section]
        switch type {
        case .filters:
            return 1
        case .films:
            return movies.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = cellTypes[indexPath.section]
        switch type {
        case .filters:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.filterCellIdentifier,
                for: indexPath
            ) as? FilterTableViewCell else { return UITableViewCell() }
            cell.sendURLClosure = { url in
                self.actualURL = url
                self.reformMovies()
            }

            return cell
        case .films:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.filmCellIdentifier,
                for: indexPath
            ) as? FilmTableViewCell else { return UITableViewCell() }

            cell.movieRefresh = movies[indexPath.row]

            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.indexPathForSelectedRow
        guard let selectedCell = selectedCell,
              let movie = tableView.cellForRow(at: selectedCell) as? FilmTableViewCell else { return }
        let filmInfoTVC = FilmInfoTableViewController()
        filmInfoTVC.movies = movie
        navigationController?.pushViewController(filmInfoTVC, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
