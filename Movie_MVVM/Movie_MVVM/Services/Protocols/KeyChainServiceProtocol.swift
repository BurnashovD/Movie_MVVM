// KeyChainServiceProtocol.swift
// Copyright © DB. All rights reserved.

import Foundation

/// Протокол сервиса сохранения данных в кичейн
protocol KeyChainServiceProtocol {
    func save(_ value: String, forKey key: String)
    func get(key: String) -> String?
}
