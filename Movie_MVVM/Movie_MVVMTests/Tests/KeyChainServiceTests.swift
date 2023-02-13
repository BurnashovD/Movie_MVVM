// KeyChainServiceTests.swift
// Copyright © DB. All rights reserved.

@testable import Movie_MVVM
import XCTest

/// Тесты кичейн сервиса
final class KeyChainServiceTests: XCTestCase {
    // MARK: - Private properties
    
    private var keychainService: KeyChainServiceProtocol?

    // MARK: - Public methods
    
    override func setUpWithError() throws {
        keychainService = MockKeyChainService()
    }

    override func tearDownWithError() throws {
        keychainService = nil
    }

    func testSave() {
        keychainService?.save(Constants.testValue, forKey: Constants.testKey)
    }

    func testGet() {
        keychainService?.save(Constants.testValue, forKey: Constants.testKey)
        guard let value = keychainService?.get(key: Constants.testKey) else { return }
        XCTAssertNotNil(value)
        XCTAssertEqual(value, Constants.testValue)
    }

    func testPerformanceExample() throws { measure {} }
}

/// Константы
private extension KeyChainServiceTests {
    enum Constants {
        static let testValue = "testValue"
        static let testKey = "test"
    }
}
