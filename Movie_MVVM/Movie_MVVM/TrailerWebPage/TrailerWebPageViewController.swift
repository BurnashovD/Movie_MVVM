// TrailerWebPageViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
import WebKit

/// Экрна с трейлером к выбранному фильму
final class TrailerWebPageViewController: UIViewController {
    // MARK: - Visual components

    private let trailerWebView: WKWebView = {
        let webConfig = WKWebViewConfiguration()
        let web = WKWebView(frame: .zero, configuration: webConfig)
        return web
    }()

    // MARK: - Public properties

    var viewModel: TrailerViewModel?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.loadWebView(webView: trailerWebView)
        view = trailerWebView
    }
}

/// Константы
extension TrailerWebPageViewController {
    enum Constants {
        static let youTubeURLString = "https://www.youtube.com/watch?v="
    }
}
