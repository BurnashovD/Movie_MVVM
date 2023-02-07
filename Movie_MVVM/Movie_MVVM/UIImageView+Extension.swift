// UIImageView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для получения изображений
extension UIImageView {
    func fetchImage(_ url: String) {
        ImageService().fetchImage(url) { data in
            self.image = UIImage(data: data)
        }
    }
}
