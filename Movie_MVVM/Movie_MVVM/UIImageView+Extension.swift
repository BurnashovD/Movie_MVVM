// UIImageView+Extension.swift
// Copyright © DB. All rights reserved.

import UIKit

/// Расширение для получения изображений
extension UIImageView {
    func fetchImage(_ url: String) {
        let proxy = Proxy()
        ImageService(proxy: proxy).fetchImage(url) { result in
            switch result {
            case let .success(data):
                self.image = UIImage(data: data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
