// Movie_MVVMUITests.swift
// Copyright © DB. All rights reserved.

import XCTest

/// UI тесты приложения
final class Movie_MVVMUITests: XCTestCase {
    // MARK: - Private properties

    private let app = XCUIApplication()

    private var filmsTableView: XCUIElement?

    // MARK: - Public methods

    override func setUpWithError() throws {
        continueAfterFailure = false
        filmsTableView = app.descendants(matching: .table).firstMatch
        app.launch()
    }

    override func tearDownWithError() throws {
        filmsTableView = nil
    }

    func testScrollTabelToLastCell() throws {
        guard let lastCell = filmsTableView?.cells.allElementsBoundByIndex.last else { return }
        while !lastCell.isHittable {
            app.swipeUp(velocity: .fast)
        }
        XCTAssertTrue(lastCell.isHittable)
    }

    func testTapOnCell() {
        let firstCell = app.tables.allElementsBoundByIndex[0].cells.allElementsBoundByIndex[1]
        firstCell.press(forDuration: 1)
        sleep(1)
    }

    func testButtonPress() {
        app.buttons[Constants.upcomingText].tap()
        sleep(1)
        app.buttons[Constants.topRatedText].tap()
        sleep(1)
        app.buttons[Constants.popularText].tap()
    }

    func testSwipeImages() {
        let tablesQuery = XCUIApplication().tables
        tablesQuery.staticTexts[Constants.cellOverviewText].tap()
        tablesQuery
            .scrollViews
            .children(matching: .image).element.swipeLeft()

        let verticalScrollBar1PageScrollView = tablesQuery.scrollViews.containing(
            .other,
            identifier: Constants.swipeAction
        ).element
        verticalScrollBar1PageScrollView.swipeRight()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

/// Константы
private extension Movie_MVVMUITests {
    enum Constants {
        static let upcomingText = "Upcoming"
        static let topRatedText = "Top rated"
        static let popularText = "Popular"
        static let cellOverviewText =
            "Побег из Шоушенка"
        static let swipeAction = "Vertical scroll bar, 1 page"
    }
}
