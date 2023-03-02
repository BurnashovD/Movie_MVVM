// TrailerViewModelProtocol.swift
// Copyright © DB. All rights reserved.

import WebKit

/// Протокол вью модели экрана с трейлером к фильму
protocol TrailerViewModelProtocol {
    var trailer: Trailer? { get set }
    func loadWebView(webView: WKWebView)
}
