// CoreDataServiceTests.swift
// Copyright © DB. All rights reserved.

@testable import Movie_MVVM
import XCTest

/// Тесты сервиса сохранения данных в кордату
final class CoreDataServiceTests: XCTestCase {
    // MARK: - Private properties

    private var coreDataService = CoreDataService()
    private var networkService = MockNetworkService()
    private var movies: [Movie]?
    private var actors: [Actor]?

    // MARK: - Public methods

    override func setUpWithError() throws {
        try super.setUpWithError()
        fetchMockMovie()
        fetchMockActors()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        movies = nil
        actors = nil
    }

    func testGetMovies() {
        guard let movies = movies else { return }
        coreDataService.saveMovies(movies)
        let coreMovie = coreDataService.getMovies(parameter: .popular)?.first(where: { $0.id == movies.first?.id })
        XCTAssertNotNil(coreMovie)
        XCTAssertEqual(coreMovie?.title, movies.first?.title)
    }

    func testGetActors() {
        guard let actors = actors, let id = movies?.first?.id else { return }
        coreDataService.saveActors(actors, id: id)
        let coreActors = coreDataService.getActors(id)
        XCTAssertNotNil(coreActors)
        XCTAssertEqual(coreActors?.first?.id, actors.first?.id)
    }

    func testPerformanceExample() throws { measure {} }

    // MARK: - Private methods

    private func fetchMockActors() {
        networkService.fetchActors(id: "") { result in
            switch result {
            case let .success(actors):
                self.actors = actors
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    private func fetchMockMovie() {
        networkService.fetchMovies(parameter: .popular) { result in
            switch result {
            case let .success(movies):
                movies.first?.filter = Constants.popularFilter
                self.movies = movies
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        }
    }
}

/// Константы
private extension CoreDataServiceTests {
    enum Constants {
        static let popularFilter = "popular"
    }
}
