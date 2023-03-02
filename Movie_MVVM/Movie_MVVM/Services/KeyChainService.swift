// KeyChainService.swift
// Copyright © DB. All rights reserved.

import Foundation
import KeychainSwift

/// Сервис сохранения данных в кичейн
struct KeyChainService: KeyChainServiceProtocol {
    // MARK: - Private properties

    private let keychain = KeychainSwift()

    // MARK: - Public methods

    func save(_ value: String, forKey key: String) {
        keychain.set(value, forKey: key)
    }

    func get(key: String) -> String? {
        guard let value = keychain.get(key) else { return "" }
        return value
    }
}
