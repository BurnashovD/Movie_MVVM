// ParseServiceTests.swift
// Copyright © DB. All rights reserved.

@testable import Movie_MVVM
import XCTest

/// Тесты парсинг сервиса
final class ParseServiceTests: XCTestCase {
    // MARK: - Public methods

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testParseMovies() {
        guard
            let data = readLocalJSONFile(fileName: Constants.movieJSONFileName),
            let movies = MockParseService.parseMoviesData(data)
        else { return }
        XCTAssertNotNil(movies)
    }

    func testParseActors() {
        guard
            let data = readLocalJSONFile(fileName: Constants.actorJSONFileName),
            let actors = MockParseService.parseActorsData(data)
        else { return }
        XCTAssertNotNil(actors)
    }

    func testParseTrailers() {
        guard
            let data = readLocalJSONFile(fileName: Constants.trailerJSONFileName),
            let trailers = MockParseService.parseTrailersData(data)
        else { return }
        XCTAssertNotNil(trailers)
    }

    func testPerformanceExample() throws { measure {} }

    // MARK: - Private methods

    private func readLocalJSONFile(fileName: String) -> Data? {
        do {
            guard let filePath = Bundle.main.path(forResource: fileName, ofType: Constants.jsonFileType)
            else { return nil }
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            return data
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

/// Константы
private extension ParseServiceTests {
    enum Constants {
        static let jsonFileType = "json"
        static let movieJSONFileName = "MovieJSON"
        static let actorJSONFileName = "ActorJSON"
        static let trailerJSONFileName = "TrailerJSON"
    }
}
