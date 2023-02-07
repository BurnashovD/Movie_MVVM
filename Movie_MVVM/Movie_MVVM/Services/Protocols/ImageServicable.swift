// ImageServicable.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол сервиса изображений
protocol ImageServicable {
    func fetchImage(_ url: String, _ completion: @escaping ((Data) -> Void))
}
