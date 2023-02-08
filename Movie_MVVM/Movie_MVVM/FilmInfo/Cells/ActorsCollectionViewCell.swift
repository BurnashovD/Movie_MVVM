// ActorsCollectionViewCell.swift
// Copyright © DB. All rights reserved.

import UIKit

/// Коллекция актеров
final class ActorsCollectionViewCell: UICollectionViewCell {
    // MARK: - Visual components

    private let actorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let actorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(actorNameLabel)
        contentView.addSubview(actorImageView)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.errorText)
    }

    // MARK: - Public methods

    override func layoutSubviews() {
        super.layoutSubviews()
        createLabelAnchors()
        createImageViewAnchors()
    }

    func configure(_ actor: Actor) {
        guard let path = actor.profilePath else { return }
        actorNameLabel.text = actor.originalName
        actorImageView.fetchImage(path)
    }

    // MARK: - Private methods

    private func createLabelAnchors() {
        actorNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        actorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        actorNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 15).isActive = true
        actorNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func createImageViewAnchors() {
        actorImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        actorImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2).isActive = true
        actorImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2).isActive = true
        actorImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
}

/// Константы
extension ActorsCollectionViewCell {
    enum Constants {
        static let errorText = "init(coder:) has not been implemented"
        static let imageURLString = "http://image.tmdb.org/t/p/w500"
        static let blueViewColorname = "blueView"
    }
}
