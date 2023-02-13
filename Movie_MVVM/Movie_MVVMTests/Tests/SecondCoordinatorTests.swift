// SecondCoordinatorTests.swift
// Copyright © DB. All rights reserved.

@testable import Movie_MVVM
import XCTest

/// Тесты второго координатора
final class SecondCoordinatorTests: XCTestCase {
    // MARK: - Private properties

    private var secondCoordinator: SecondCoordinatorProtocol?
    private var navController = MainNavigationController()
    private var networkService = MockNetworkService()
    private var builder = ModulBuilder()
    private var parentCoordinator: Coordinatable?
    private var movie: Movie?
    private var trailer: Trailer?

    // MARK: - Public methods

    override func setUpWithError() throws {
        try super.setUpWithError()
        fetchMockMovie()
        fetchMockTrailer()
        parentCoordinator = MainCoordintor(navigationController: navController, builder: builder)
        guard let parentCoordinator = parentCoordinator, let movie = movie else { return }
        secondCoordinator = SecondCoordinator(
            navigationController: navController,
            builder: builder,
            parentCoordinator: parentCoordinator,
            movie: movie
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        parentCoordinator = nil
        movie = nil
        secondCoordinator = nil
    }

    func testInitial() {
        secondCoordinator?.initial()
        let root = navController.viewControllers.first
        XCTAssertTrue(root is FilmInfoTableViewController)
    }

    func testDidFinish() {
        secondCoordinator?.didFinish()
        XCTAssertTrue(parentCoordinator?.childCoordinators.isEmpty == true)
    }

    func testOpenWebView() {
        secondCoordinator?.initial()
        guard let trailer = trailer else { return }
        secondCoordinator?.openWeb(trailer)
        XCTAssertTrue(navController.visibleViewController is FilmInfoTableViewController)
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
