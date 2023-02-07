// FilmTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с информацией о фильме
final class FilmTableViewCell: UITableViewCell {
    // MARK: - Visual components

    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.backgroundColor = UIColor(named: Constants.cellViewColorName)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 7
        view.layer.shadowOpacity = 0.5
        return view
    }()

    private let filmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let filmNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let filmRateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .green
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let filmOverviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Private properties

    private var filmId = ""
    private var backdropImageId = ""

    // MARK: - Public properties

    var movie: Movie?
    var viewData: ViewData = .initial

    // MARK: - Public properties

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configUI()
    }

    // MARK: - Private methods

    func createCurrentMovie() {
        movie = Movie(
            backdropPath: backdropImageId,
            id: Int(filmId) ?? 0,
            overview: filmOverviewLabel.text ?? "",
            posterPath: "",
            title: filmNameLabel.text ?? "",
            voteAverage: 0.0,
            filmImage: filmImageView.image ?? UIImage(),
            currentFilmId: filmId
        )
    }

    func configure(_ movie: Movie) {
        filmNameLabel.text = movie.title
        filmRateLabel.text = String(movie.voteAverage)
        filmOverviewLabel.text = movie.overview
        filmId = String(movie.id)
        backdropImageId = movie.backdropPath
        filmImageView.fetchImage(movie.posterPath)
    }

    func viewUpdate(viewData: ViewData, _ index: Int) {
        self.viewData = viewData
        switch viewData {
        case .initial:
            break
        case .loading:
            configureLoadingCell()
        case let .success(movie):
            configure(movie[index])
        case let .failure(error):
            print(error.localizedDescription)
        }
    }

    private func configureLoadingCell() {
        filmImageView.image = UIImage(systemName: "person")
        filmNameLabel.text = "Loading..."
        filmOverviewLabel.text = "Please wait some more time"
    }

    private func configUI() {
        backgroundColor = UIColor(named: Constants.blueViewColorName)
        selectionStyle = .none
        cellView.addSubview(filmImageView)
        cellView.addSubview(filmNameLabel)
        cellView.addSubview(filmRateLabel)
        cellView.addSubview(filmOverviewLabel)
        contentView.addSubview(cellView)
        createFilmImageViewAnchors()
        createViewAnchors()
        createFilmNameLabelAnchors()
        createFilmRatesAnchors()
        createFilmOverviewLabelAnchors()
    }

    private func createViewAnchors() {
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
    }

    private func createFilmImageViewAnchors() {
        filmImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20).isActive = true
        filmImageView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10).isActive = true
        filmImageView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10).isActive = true
        filmImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        filmImageView.heightAnchor.constraint(equalToConstant: 170).isActive = true
    }

    private func createFilmNameLabelAnchors() {
        filmNameLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10).isActive = true
        filmNameLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 15).isActive = true
        filmNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        filmNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func createFilmRatesAnchors() {
        filmRateLabel.topAnchor.constraint(equalTo: filmNameLabel.bottomAnchor, constant: 105).isActive = true
        filmRateLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 160).isActive = true
        filmRateLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        filmRateLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func createFilmOverviewLabelAnchors() {
        filmOverviewLabel.topAnchor.constraint(equalTo: filmNameLabel.bottomAnchor, constant: 0).isActive = true
        filmOverviewLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 8).isActive = true
        filmOverviewLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -8).isActive = true
        filmOverviewLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -40).isActive = true
    }
}

/// Константы
extension FilmTableViewCell {
    enum Constants {
        static let cellViewColorName = "cellViewColor"
        static let blueViewColorName = "blueView"
        static let imageURLString = "http://image.tmdb.org/t/p/w500"
    }
}
