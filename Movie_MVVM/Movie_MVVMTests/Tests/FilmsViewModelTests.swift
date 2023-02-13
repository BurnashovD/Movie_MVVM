// FilmsViewModelTests.swift
// Copyright © DB. All rights reserved.

@testable import Movie_MVVM
import XCTest

/// Тесты вью модели экрана списка фильмов
final class FilmsViewModelTests: XCTestCase {
    // MARK: - Private properties

    private var networkService = MockNetworkService()
    private var imageService = MockImageService()
    private var coreDataService = CoreDataService()
    private var keychainService = MockKeyChainService()
    private var builder = ModulBuilder()
    private var coordinator: Coordinatable?
    private var movies: [Movie] = []
    private var filmsViewModel: FilmsViewModelProtocol?

    // MARK: - Public methods

    override func setUpWithError() throws {
        coordinator = MainCoordintor(navigationController: MainNavigationController(), builder: builder)
        guard let coordinator = coordinator else { return }
        filmsViewModel = FilmsViewModel(
            networkService: networkService,
            imageService: imageService,
            coreDataService: coreDataService,
            keyChainService: keychainService,
            coordinator: coordinator
        )
    }

    override func tearDownWithError() throws {
        filmsViewModel = nil
    }

    func testFetchMovies() {
        fetchMockMovie()
        XCTAssertEqual(filmsViewModel?.viewData, .initial)
        filmsViewModel?.fetchMovies(.popular)
        XCTAssertEqual(filmsViewModel?.viewData, .success(movies))
    }

    func testLoadMovies() {
        fetchMockMovie()
        filmsViewModel?.loadMovies(.popular)
        XCTAssertEqual(filmsViewModel?.viewData, .success(movies))
    }

    func testMoviesCount() {
        fetchMockMovie()
        let count = filmsViewModel?.moviesCount()
        switch filmsViewModel?.viewData {
        case .initial:
            XCTAssertEqual(count, 0)
        case .loading:
            XCTAssertEqual(count, 1)
        case let .success(movies):
            XCTAssertEqual(movies.count, count)
        case .failure:
            XCTAssertEqual(count, 1)
        case .none:
            break
        }
    }

    func testSaveApiAction() {
        filmsViewModel?.saveApiKeyAction(Constants.testApiKey, filter: .popular)
        let isKeySetted = UserDefaults.standard.bool(forKey: Constants.testValue)
        XCTAssertTrue(isKeySetted)
    }

    func testCheckApiKeyAction() {
        filmsViewModel?.apiKeyCheckAction({
            testSaveApiAction()
            guard let value = keychainService.get(key: Constants.testApiKey) else { return }
            XCTAssertEqual(value, Constants.testApiKey)
        }, filter: .popular)
    }

    func testSelectedRowAction() {
        fetchMockMovie()
        let table = UITableView()
        let indexPath = IndexPath()
        filmsViewModel?.selectedRowAction(tableView: table, selectedCell: indexPath)
        guard let movie = movies.first else { return }
        coordinator?.addDependency(movie: movie)
        XCTAssertTrue(coordinator?.childCoordinators.first is SecondCoordinator)
    }

    func testPerformanceExample() throws { measure {} }

    // MARK: - Private methods

    private func fetchMockMovie() {
        networkService.fetchMovies(parameter: .popular) { result in
            switch result {
            case let .success(movies):
                self.movies = movies
            case let .failure(error):
                XCTAssertNotNil(error)
            }
        }
    }
}

/// Константы
private extension FilmsViewModelTests {
    enum Constants {
        static let testApiKey = "56c45ba32cd76399770966658bf65ca0"
        static let testKey = "testKey"
        static let testValue = "key"
    }
}
