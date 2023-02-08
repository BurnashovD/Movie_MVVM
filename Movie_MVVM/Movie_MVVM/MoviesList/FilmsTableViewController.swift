// FilmsTableViewController.swift
// Copyright © DB. All rights reserved.

import UIKit

/// Экран списка фильмов
final class FilmsTableViewController: UITableViewController {
    // MARK: - Public properties

    var viewModel: FilmsViewModelProtocol?
    var viewData: ViewData = .initial {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Private properties

    private var actualFilter: NetworkService.ParameterType = .topRated
    private var cellTypes: [CellTypes] = [.filters, .films]

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel?.fetchMovies(actualFilter)
        updateViewData()
    }

    // MARK: - Private methods

    private func configureUI() {
        title = Constants.filmsText
        view.backgroundColor = UIColor(named: Constants.blueViewColorName)
        configureCells()
    }

    private func updateViewData() {
        viewModel?.updateHandler = { [weak self] viewData in
            guard let self = self else { return }
            self.viewData = viewData
        }
    }

    private func configureCells() {
        tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: Constants.filmCellIdentifier)
        tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: Constants.filterCellIdentifier)
        tableView.showsVerticalScrollIndicator = false
    }
}

/// Константы и типы ячеек
extension FilmsTableViewController {
    enum Constants {
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
            guard let viewModel = viewModel else { return 0 }
            return viewModel.moviesCount()
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
            cell.sendURLHandler = { [weak self] filter in
                guard let self = self else { return }
                self.actualFilter = filter
                self.viewModel?.fetchMovies(self.actualFilter)
            }

            return cell
        case .films:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.filmCellIdentifier,
                for: indexPath
            ) as? FilmTableViewCell else { return UITableViewCell() }

            cell.viewUpdate(viewData: viewData, indexPath.row)

            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.indexPathForSelectedRow
        viewModel?.selectedRowAction(tableView: tableView, selectedCell: selectedCell)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
