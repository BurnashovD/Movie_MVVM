// TrailerTableViewCell.swift
// Copyright © DB. All rights reserved.

import UIKit

/// Ячейка с постерами к выбранному фильму
final class TrailerTableViewCell: UITableViewCell {
    // MARK: - Visual components

    private let filmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private let secondFilmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var filmImagesScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentSize = CGSize(width: 780, height: 200)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(filmImageView)
        scroll.addSubview(secondFilmImageView)
        scroll.isPagingEnabled = true
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()

    // MARK: - Public properties

    var openWebHandler: (() -> Void)?

    // MARK: - Private properties

    private lazy var tapFilmImageViewRecognizer = UITapGestureRecognizer(
        target: self,
        action: #selector(openTrailerWebPageAction)
    )

    // MARK: - Public methods

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureUI()
    }

    func configure(_ movie: Movie) {
        secondFilmImageView.image = movie.filmImage
        filmImageView.fetchImage(movie.backdropPath)
    }

    // MARK: - Private methods

    private func configureUI() {
        selectionStyle = .none
        contentView.addSubview(filmImagesScrollView)
        contentView.backgroundColor = UIColor(named: Constants.blueViewColorname)
        createScrollViewAnchors()
        createFilmImageViewAnchors()
        createSecondImageviewAnchors()
        filmImageView.addGestureRecognizer(tapFilmImageViewRecognizer)
    }

    private func createScrollViewAnchors() {
        filmImagesScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        filmImagesScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        filmImagesScrollView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        filmImagesScrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        filmImagesScrollView.heightAnchor.constraint(equalToConstant: 220).isActive = true
    }

    private func createFilmImageViewAnchors() {
        filmImageView.leadingAnchor.constraint(equalTo: filmImagesScrollView.leadingAnchor, constant: 10)
            .isActive = true
        filmImageView.topAnchor.constraint(equalTo: filmImagesScrollView.topAnchor, constant: 5).isActive = true
        filmImageView.centerXAnchor.constraint(equalTo: filmImagesScrollView.centerXAnchor).isActive = true
        filmImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        filmImageView.heightAnchor.constraint(equalToConstant: 210).isActive = true
    }

    private func createSecondImageviewAnchors() {
        secondFilmImageView.topAnchor.constraint(equalTo: filmImagesScrollView.topAnchor, constant: 5).isActive = true
        secondFilmImageView.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 60)
            .isActive = true
        secondFilmImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        secondFilmImageView.heightAnchor.constraint(equalToConstant: 210).isActive = true
    }

    @objc private func openTrailerWebPageAction() {
        openWebHandler?()
    }
}

/// Константы
extension TrailerTableViewCell {
    enum Constants {
        static let blueViewColorname = "blueView"
        static let trailerImageURLString = "http://image.tmdb.org/t/p/w500"
    }
}
