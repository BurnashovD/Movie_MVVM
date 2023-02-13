// TrailerViewModelTests.swift
// Copyright © DB. All rights reserved.

@testable import Movie_MVVM
import WebKit
import XCTest

/// Тесты вью модели экрана с трейлером к фильму
final class TrailerViewModelTests: XCTestCase {
    // MARK: - Private properties

    private var trailerViewModel: TrailerViewModelProtocol?
    private var coordinator: SecondCoordinatorProtocol?
    private var networkService = MockNetworkService()
    private var trailer: Trailer?
    private var builder = ModulBuilder()
    private let webView = WKWebView()
    private var movie: Movie?

    // MARK: - Public methods

    override func setUpWithError() throws {
        fetchMockTrailer()
        fetchMockMovie()
        guard let movie = movie else { return }
        coordinator = SecondCoordinator(
            navigationController: MainNavigationController(),
            builder: builder,
            parentCoordinator: MainCoordintor(navigationController: MainNavigationController(), builder: builder),
            movie: movie
        )
        guard let coordinator = coordinator, let trailer = trailer else { return }
        trailerViewModel = TrailerViewModel(trailer: trailer, coordinator: coordinator)
    }

    override func tearDownWithError() throws {
        trailerViewModel = nil
        trailer = nil
    }

    func testLoadWeb() {
        trailerViewModel?.loadWebView(webView: webView)
        XCTAssertTrue(webView.isLoading)
        XCTAssertEqual(trailerViewModel?.trailer?.id, trailer?.id)
    }

    func testPerformanceExample() throws { measure {} }

    // MARK: - Private methods

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
