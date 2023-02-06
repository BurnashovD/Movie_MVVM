// TrailerWebPageViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

// Класс открывает контроллер с WebView с ссылкой на трейлер к фильму
final class TrailerWebPageViewController: UIViewController {
    // MARK: - Visual components

    private let trailerWebView: WKWebView = {
        let webConfig = WKWebViewConfiguration()
        let web = WKWebView(frame: .zero, configuration: webConfig)
        return web
    }()

    // MARK: Public properties

    var movieId = ""
    var trailerURLString = ""
    var refresh: TrailerResult? {
        didSet {
            guard let refreshKey = refresh?.key else { return }
            trailerURLString = "\(Constants.youTubeURLString)\(refreshKey)"
        }
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configWeb()
    }

    // MARK: - Private methods

    private func configWeb() {
        guard let trailerURL = URL(string: trailerURLString) else { return }
        let productRequest = URLRequest(url: trailerURL)
        trailerWebView.load(productRequest)
        view = trailerWebView
    }
}

extension TrailerWebPageViewController {
    enum Constants {
        static let youTubeURLString = "https://www.youtube.com/watch?v="
    }
}
