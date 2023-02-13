// MockKeyChainService.swift
// Copyright © DB. All rights reserved.

import Foundation
import KeychainSwift
@testable import Movie_MVVM

/// Мок кичейн сервиса
final class MockKeyChainService: KeyChainServiceProtocol {
    // MARK: - Private propeties
    
    private var keychain = KeychainSwift()

    // MARK: - Public methods
    
    func save(_ value: String, forKey key: String) {
        keychain.set(value, forKey: key)
    }

    func get(key: String) -> String? {
        guard let value = keychain.get(key) else { return nil }
        return value
    }
}
