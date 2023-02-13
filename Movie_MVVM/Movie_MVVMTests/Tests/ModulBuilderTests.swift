// ModulBuilderTests.swift
// Copyright © DB. All rights reserved.

@testable import Movie_MVVM
import XCTest

/// Тесты сборщика модулей
final class ModulBuilderTests: XCTestCase {
    // MARK: - Private properties
    
    private var builder: BuilderProtocol?
    private var coordinator: SecondCoordinatorProtocol?
    private var movie: Movie?
    private var networkService = MockNetworkService()
    private var trailer: Trailer?

    // MARK: - Public methods
    
    override func setUpWithError() throws {
        fetchMockMovie()
        fetchMockTrailer()
        builder = ModulBuilder()
        guard let builder = builder, let movie = movie else { return }
        coordinator = SecondCoordinator(
            navigationController: UINavigationController(),
            builder: builder,
            parentCoordinator: MainCoordintor(navigationController: MainNavigationController(), builder: builder),
            movie: movie
        )
    }

    override func tearDownWithError() throws {
        builder = nil
    }

    func testMakeFilmsInfoVC() {
        guard let coordinator = coordinator, let movie = movie else { return }
        let infoVC = builder?.makeFilmInfoModule(coordinator: coordinator, movie: movie)
        XCTAssertTrue(infoVC is FilmInfoTableViewController)
    }

    func testMakeFilmsVC() {
        guard let coordinator = coordinator else { return }
        let filmVC = builder?.makeFilmsModule(coordinator: coordinator)
        XCTAssertTrue(filmVC is FilmsTableViewController)
    }

    func testMakeWebPageVC() {
        guard let coordinator = coordinator, let trailer = trailer else { return }
        let trailerVC = builder?.makeTrailerWebViewModule(coordinator: coordinator, trailer: trailer)
        XCTAssertTrue(trailerVC is TrailerWebPageViewController)
    }

    func testPerformanceExample() throws { measure {} }

    // MARK: - Private methods
    
    private func fetchMockMovie() {
        networkService.fetchMovies(parameter: .popular) { result in
            switch result {
            case let .success(movies):
                self.movie = movies.first
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        }
    }

    private func fetchMockTrailer() {
        networkService.fetchTrailers(id: "") { result in
            switch result {
            case let .success(trailers):
                self.trailer = trailers.first
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        }
    }
}
