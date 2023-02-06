// TrailerTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Класс отвечает за ячейку с трейлером к фильму
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

    private lazy var tapFilmImageViewRecognizer = UITapGestureRecognizer(
        target: self,
        action: #selector(openTrailerWebPageAction)
    )

    // MARK: - Public properties

    var sendOpenWebPageAction: (() -> Void)?
    private var backdropImageId = String()

    // MARK: - LifeCycle

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configUI()
        getTrailerImage()
    }

    func refresh(_ filmInfo: FilmInfoTableViewController) {
        secondFilmImageView.image = filmInfo.posterimage
        backdropImageId = filmInfo.backdropImageId
    }

    // MARK: - Private methods

    private func configUI() {
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

    private func getTrailerImage() {
        let imageURL = "\(Constants.trailerImageURLString)\(backdropImageId)"
        guard let url = URL(string: imageURL) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in

            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.filmImageView.image = UIImage(data: data)
            }
        }.resume()
    }

    @objc private func openTrailerWebPageAction() {
        sendOpenWebPageAction?()
    }
}

/// Constants
extension TrailerTableViewCell {
    enum Constants {
        static let blueViewColorname = "blueView"
        static let trailerImageURLString = "http://image.tmdb.org/t/p/w500"
    }
}
