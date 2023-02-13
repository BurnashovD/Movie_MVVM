// CoordinatorTests.swift
// Copyright © DB. All rights reserved.

@testable import Movie_MVVM
import XCTest

/// Тесты координатора
final class CoordinatorTests: XCTestCase {
    // MARK: - Private properties

    private var mainCoordinator: Coordinatable?
    private var childCoordinator: SecondCoordinatorProtocol?
    private var networkService = MockNetworkService()
    private var builder = ModulBuilder()
    private var navController = MainNavigationController()
    private var movie: Movie?

    // MARK: - Public methods

    override func setUpWithError() throws {
        try super.setUpWithError()
        fetchMockMovie()
        mainCoordinator = MainCoordintor(navigationController: navController, builder: builder)
        guard let mainCoordinator = mainCoordinator, let movie = movie else { return }
        childCoordinator = SecondCoordinator(
            navigationController: navController,
            builder: builder,
            parentCoordinator: mainCoordinator,
            movie: movie
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        mainCoordinator = nil
    }

    func testInitial() {
        mainCoordinator?.initial()
        XCTAssertTrue(navController.viewControllers.first is FilmsTableViewController)
    }

    func testAddDependency() {
        guard let movie = movie else { return }
        mainCoordinator?.addDependency(movie: movie)
        let child = mainCoordinator?.childCoordinators.first
        XCTAssertTrue(child is SecondCoordinator)
    }

    func testRemoveDependency() {
        guard let movie = movie, let mainCoordinator = mainCoordinator else { return }
        mainCoordinator.childDidFinish(child: SecondCoordinator(
            navigationController: navController,
            builder: builder,
            parentCoordinator: mainCoordinator,
            movie: movie
        ))
        XCTAssertTrue(mainCoordinator.childCoordinators.isEmpty)
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
}
