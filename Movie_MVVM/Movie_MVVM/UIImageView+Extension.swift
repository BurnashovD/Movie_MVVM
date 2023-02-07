// UIImageView+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIImageView {
    func fetchImage(_ url: String) {
        NetworkService().fetchImage(url) { [weak self] result in
            switch result {
            case let .success(data):
                self?.image = UIImage(data: data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
