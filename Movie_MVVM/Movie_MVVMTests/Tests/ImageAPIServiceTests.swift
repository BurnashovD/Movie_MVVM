// ImageAPIServiceTests.swift
// Copyright © DB. All rights reserved.

@testable import Movie_MVVM
import XCTest

/// Тесты сервиса получения данных изображений
final class ImageAPIServiceTests: XCTestCase {
    // MARK: - Private properties

    private var imageAPIService: ImageAPIServicable?

    // MARK: - Public methods

    override func setUpWithError() throws {
        imageAPIService = MockImageAPIService()
    }

    override func tearDownWithError() throws {
        imageAPIService = nil
    }

    func testFetchImage() {
        imageAPIService?.fetchImage("") { result in
            switch result {
            case let .success(data):
                let imageData = UIImage(systemName: Constants.noteImageName)?.pngData()
                XCTAssertEqual(imageData, data)
                XCTAssertNotNil(data)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        }
    }

    func testPerformanceExample() throws { measure {} }
}

/// Константы
private extension ImageAPIServiceTests {
    enum Constants {
        static let noteImageName = "note"
    }
}
