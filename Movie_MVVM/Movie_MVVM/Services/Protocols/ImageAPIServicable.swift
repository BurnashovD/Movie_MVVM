// ImageAPIServicable.swift
// Copyright © DB. All rights reserved.

import Foundation

/// Протокол сервиса по получению изображений
protocol ImageAPIServicable {
    func fetchImage(_ url: String, _ completion: @escaping (Result<Data, Error>) -> Void)
}
