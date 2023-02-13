// NetworkServiceTests.swift
// Copyright © DB. All rights reserved.

@testable import Movie_MVVM
import XCTest

/// Тесты сетевого слоя
final class NetworkServiceTests: XCTestCase {
    // MARK: - Private properties
    
    private var networkService: NetworkServicable?

    // MARK: - Public methods
    
    override func setUpWithError() throws {
        networkService = MockNetworkService()
    }

    override func tearDownWithError() throws {
        networkService = nil
    }

    func testFetchMovies() {
        networkService?.fetchMovies(parameter: .popular) { result in
            switch result {
            case let .success(movies):
                XCTAssertNotNil(movies)
                XCTAssertEqual(movies.first?.id, Constants.testMovieId)
                XCTAssertEqual(movies.first?.title, Constants.testMovieTitle)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        }
    }

    func testFetchActors() {
        networkService?.fetchActors(id: "") { result in
            switch result {
            case let .success(actors):
                XCTAssertNotNil(actors)
                XCTAssertEqual(actors.first?.id, Constants.testActorId)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        }
    }

    func testfetchTrailers() {
        networkService?.fetchTrailers(id: "") { result in
            switch result {
            case let .success(trailers):
                XCTAssertNotNil(trailers)
                XCTAssertEqual(trailers.first?.id, Constants.testTrailerId)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        }
    }

    func testPerformanceExample() throws { measure {} }
}

/// Константы
private extension NetworkServiceTests {
    enum Constants {
        static let testTrailerId = "1"
        static let testActorId = 1
        static let testMovieTitle = "Foo"
        static let testMovieId = 0
    }
}
