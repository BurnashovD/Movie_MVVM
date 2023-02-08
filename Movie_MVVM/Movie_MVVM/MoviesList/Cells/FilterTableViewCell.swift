// FilterTableViewCell.swift
// Copyright © DB. All rights reserved.

import UIKit

/// Ячейка с выбором категории фильмов
final class FilterTableViewCell: UITableViewCell {
    // MARK: - Visual components

    private let topRatedButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: Constants.buttonsColorName)
        button.layer.cornerRadius = 7
        button.setTitle(Constants.topRatedText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        return button
    }()

    private let upcomingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: Constants.buttonsColorName)
        button.layer.cornerRadius = 7
        button.setTitle(Constants.upcomingText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        return button
    }()

    private let popularButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: Constants.buttonsColorName)
        button.layer.cornerRadius = 7
        button.setTitle(Constants.popularText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        return button
    }()

    // MARK: - Public properties

    var sendURLHandler: ((NetworkService.ParameterType) -> Void)?

    // MARK: - Public methods

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundColor = UIColor(named: Constants.blueViewColorName)
        configureUI()
    }

    // MARK: - Private methods

    private func configureUI() {
        selectionStyle = .none
        contentView.addSubview(topRatedButton)
        contentView.addSubview(upcomingButton)
        contentView.addSubview(popularButton)
        topRatedButton.addTarget(self, action: #selector(sendTopRatedURLAction), for: .touchUpInside)
        upcomingButton.addTarget(self, action: #selector(sendUpcomingdURLAction), for: .touchUpInside)
        popularButton.addTarget(self, action: #selector(sendPopularURLAction), for: .touchUpInside)
        createTopRatedButtonAnchors()
        createUpcomingButtonAnchors()
        createPopularButtonAnchors()
    }

    private func createTopRatedButtonAnchors() {
        topRatedButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        topRatedButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        topRatedButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        topRatedButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }

    private func createUpcomingButtonAnchors() {
        upcomingButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        upcomingButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        upcomingButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        upcomingButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }

    private func createPopularButtonAnchors() {
        popularButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        popularButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        popularButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        popularButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        popularButton.heightAnchor.constraint(equalToConstant: 30).isActive = false
    }

    @objc private func sendTopRatedURLAction() {
        sendURLHandler?(.topRated)
    }

    @objc private func sendUpcomingdURLAction() {
        sendURLHandler?(.upcoming)
    }

    @objc private func sendPopularURLAction() {
        sendURLHandler?(.popular)
    }
}

/// Константы
extension FilterTableViewCell {
    enum Constants {
        static let buttonsColorName = "buttonsColor"
        static let blueViewColorName = "blueView"
        static let topRatedText = "Top rated"
        static let upcomingText = "Upcoming"
        static let popularText = "Popular"
    }
}
