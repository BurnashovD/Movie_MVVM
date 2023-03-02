// ImageServicable.swift
// Copyright © DB. All rights reserved.

import Foundation

/// Протокол сервиса изображений
protocol ImageServicable {
    func fetchImage(_ url: String, _ completion: @escaping ((Result<Data, Error>) -> Void))
}
