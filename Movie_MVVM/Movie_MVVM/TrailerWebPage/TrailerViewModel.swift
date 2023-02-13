// TrailerViewModel.swift
// Copyright © DB. All rights reserved.

import Foundation
import WebKit

/// Вью модель экрана с трейлером к фильму
final class TrailerViewModel: TrailerViewModelProtocol {
    // MARK: - Public properties

    var trailer: Trailer?

    // MARK: - Private properties

    private var coordinator: SecondCoordinatorProtocol

    // MARK: - init

    init(trailer: Trailer?, coordinator: SecondCoordinatorProtocol) {
        self.trailer = trailer
        self.coordinator = coordinator
    }

    // MARK: - Public methods

    func loadWebView(webView: WKWebView) {
        guard
            let trailer = trailer,
            let url = URL(string: "\(Constants.youTubeURLString)\(trailer.key)")
        else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

/// Константы
private extension TrailerViewModel {
    enum Constants {
        static let youTubeURLString = "https://www.youtube.com/watch?v="
    }
}
