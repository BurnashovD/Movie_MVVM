// ImageServiceTests.swift
// Copyright © DB. All rights reserved.

@testable import Movie_MVVM
import XCTest

/// Тесты сервиса обработки изображений
final class ImageServiceTests: XCTestCase {
    // MARK: - Private properties
    
    private var imageService: ImageServicable?

    // MARK: - Public methods
    
    override func setUpWithError() throws {
        imageService = MockImageService()
    }

    override func tearDownWithError() throws {
        imageService = nil
    }

    func testFetchImage() {
        imageService?.fetchImage("") { result in
            switch result {
            case let .success(data):
                guard let imageData = UIImage(systemName: Constants.noteImageName)?.pngData() else { return }
                XCTAssertNotNil(data)
                XCTAssertEqual(data, imageData)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        }
    }

    func testPerformanceExample() throws { measure {} }
}

/// Константы
private extension ImageServiceTests {
    enum Constants {
        static let noteImageName = "note"
    }
}
