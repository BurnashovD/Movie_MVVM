// UIImageView+Extension.swift
// Copyright © DB. All rights reserved.

import UIKit

/// Расширение для получения изображений
extension UIImageView {
    func fetchImage(_ url: String) {
        let proxy = Proxy()
        ImageService(proxy: proxy).fetchImage(url) { data in
            self.image = UIImage(data: data)
        }
    }
}
