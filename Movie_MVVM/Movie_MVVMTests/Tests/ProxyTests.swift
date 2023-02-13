// ProxyTests.swift
// Copyright © DB. All rights reserved.

@testable import Movie_MVVM
import XCTest

/// Тесты прокси сервиса
final class ProxyTests: XCTestCase {
    // MARK: - Private properties

    private var proxy: ProxyProtocol?

    // MARK: - Public methods

    override func setUpWithError() throws {
        proxy = MockProxy()
    }

    override func tearDownWithError() throws {
        proxy = nil
    }

    func testLoadFromCache() {
        proxy?.loadFromCache(posterPath: Constants.testPathValue) { data in
            guard let imageData = UIImage(systemName: Constants.noteImageName)?.pngData() else { return }
            XCTAssertNotNil(data)
            XCTAssertEqual(data, imageData)
        }
    }

    func testPerformanceExample() throws { measure {} }
}

/// Константы
private extension ProxyTests {
    enum Constants {
        static let noteImageName = "note"
        static let testPathValue = "test"
    }
}
