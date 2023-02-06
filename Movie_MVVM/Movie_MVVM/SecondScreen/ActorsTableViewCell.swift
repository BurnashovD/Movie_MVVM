// ActorsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Класс отвечает за ячейку с актерами
final class ActorsTableViewCell: UITableViewCell {
    // MARK: - Visual components

    let actorsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 1, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = UIColor(named: Constants.blueViewColorName)
        return collection
    }()

    // MARK: - Public properties

    var filmId = ""
    var actorsResults = [Cast]()

    // MARK: - LifeCycle

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configUI()
    }

    public func refresh(filmInfo: FilmInfoTableViewController) {
        filmId = filmInfo.filmId
        actorsResults = filmInfo.actorsResults
    }

    // MARK: - Private func

    private func configUI() {
        backgroundColor = UIColor(named: Constants.blueViewColorName)
        actorsCollectionView.delegate = self
        actorsCollectionView.dataSource = self
        actorsCollectionView.register(
            ActorsCollectionViewCell.self,
            forCellWithReuseIdentifier: Constants.cellIdentifier
        )
        contentView.addSubview(actorsCollectionView)
        createCollectionViewAnchors()
    }

    private func createCollectionViewAnchors() {
        actorsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        actorsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        actorsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        actorsCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1).isActive = true
        actorsCollectionView.heightAnchor.constraint(equalToConstant: 140).isActive = true
    }
}

/// Constants
extension ActorsTableViewCell {
    enum Constants {
        static let cellIdentifier = "cell"
        static let blueViewColorName = "blueView"
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension ActorsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        actorsResults.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.cellIdentifier,
            for: indexPath
        ) as? ActorsCollectionViewCell else { return UICollectionViewCell() }

        cell.refreshActors = actorsResults[indexPath.row]
        return cell
    }
}
