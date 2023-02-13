// FilmInfoViewModelTests.swift
// Copyright © DB. All rights reserved.

@testable import Movie_MVVM
import XCTest

/// Тесты вью модели экрана с информацией о выбранном фильме
final class FilmInfoViewModelTests: XCTestCase {
    // MARK: - Private properties

    private var networkService = MockNetworkService()
    private var imageService = MockImageService()
    private var coreDataService = CoreDataService()
    private var keychainService = MockKeyChainService()
    private var coordinator: SecondCoordinatorProtocol?
    private var filmInfoViewModel: FilmInfoViewModelProtocol?
    private var builder = ModulBuilder()
    private var movie: Movie?
    private var actors: [Actor]?
    private var trailers: [Trailer]?

    // MARK: - Public methods

    override func setUpWithError() throws {
        try super.setUpWithError()
        fetchMockMovie()
        fetchMockActors()
        fetchMockTrailer()
        guard let movie = movie else { return }
        coordinator = SecondCoordinator(
            navigationController: MainNavigationController(),
            builder: builder,
            parentCoordinator: MainCoordintor(navigationController: MainNavigationController(), builder: builder),
            movie: movie
        )
        guard let coordinator = coordinator else { return }
        filmInfoViewModel = FilmInfoViewModel(
            networkService: networkService,
            imageService: imageService,
            coreDataService: coreDataService,
            movie: movie,
            coordinator: coordinator
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        filmInfoViewModel = nil
        movie = nil
        actors = nil
        trailers = nil
    }

    func testFetchActors() {
        filmInfoViewModel?.fetchActors()
        XCTAssertEqual(actors?.first?.id, filmInfoViewModel?.actors.first?.id)
    }

    func testLoadActors() {
        filmInfoViewModel?.loadActors()
        XCTAssertNotNil(filmInfoViewModel?.actors)
        XCTAssertEqual(actors?.first?.id, filmInfoViewModel?.actors.first?.id)
    }

    func testFetchTrailers() {
        filmInfoViewModel?.fetchTrailers()
        XCTAssertNotNil(filmInfoViewModel?.trailers)
        XCTAssertEqual(trailers?.first?.id, filmInfoViewModel?.trailers.first?.id)
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
                self.trailers = trailers
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        }
    }
}
