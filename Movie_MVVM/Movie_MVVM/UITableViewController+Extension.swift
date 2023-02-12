// UITableViewController+Extension.swift
// Copyright © DB. All rights reserved.

import UIKit

/// Расширение для вызова алерта
extension UITableViewController {
    func callAlert(title: String, actionTitle: String, _ completion: @escaping (String) -> Void) {
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert
        )
        alert.addTextField()

        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            guard let key = alert.textFields?.first?.text else { return }
            completion(key)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}
