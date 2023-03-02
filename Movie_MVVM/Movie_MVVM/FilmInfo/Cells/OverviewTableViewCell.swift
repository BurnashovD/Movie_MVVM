// OverviewTableViewCell.swift
// Copyright © DB. All rights reserved.

import UIKit

/// Ячейка с описанием к фильму
final class OverviewTableViewCell: UITableViewCell {
    // MARK: - Visual components

    private let overviewTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = Constants.overviewText
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    // MARK: - Public methods

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configUI()
    }

    func configure(movie: Movie) {
        overviewLabel.text = movie.overview
    }

    // MARK: - Private methods

    private func configUI() {
        backgroundColor = UIColor(named: Constants.blueViewColorName)
        selectionStyle = .none
        contentView.addSubview(overviewTextLabel)
        contentView.addSubview(overviewLabel)
        createOverviewTextLabelAnchors()
        createOverviewLabelAnchors()
    }

    private func createOverviewTextLabelAnchors() {
        overviewTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        overviewTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        overviewTextLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        overviewTextLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func createOverviewLabelAnchors() {
        overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        overviewLabel.topAnchor.constraint(equalTo: overviewTextLabel.topAnchor, constant: 0).isActive = true
        overviewLabel.heightAnchor.constraint(equalToConstant: 280).isActive = true
    }
}

/// Константы
extension OverviewTableViewCell {
    enum Constants {
        static let blueViewColorName = "blueView"
        static let overviewText = "Описание"
    }
}
