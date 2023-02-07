// TrailerViewModelProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол вью модели экрана с трейлером к фильму
protocol TrailerViewModelProtocol {
    associatedtype WebView
    var trailer: Trailer? { get set }
    func loadWebView(webView: WebView)
}
