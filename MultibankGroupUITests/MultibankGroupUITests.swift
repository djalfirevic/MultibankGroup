//
//  MultibankGroupUITests.swift
//  MultibankGroupUITests
//
//  Created by Djuro Alfirevic on 3/4/26.
//

import XCTest

final class MultibankGroupUITests: XCTestCase {

    // MARK: - Properties

    private var app: XCUIApplication!

    // MARK: - XCTestCase

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    // MARK: - Feed Screen

    func testFeedScreenShowsNavigationTitle() {
        let navBar = app.navigationBars["Price Feed"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 5))
    }

    func testFeedScreenShowsStartButton() {
        let startButton = app.buttons["feedToggle"]
        XCTAssertTrue(startButton.waitForExistence(timeout: 5))
        XCTAssertEqual(startButton.label, "Start")
    }

    func testFeedScreenShowsConnectionStatusIndicator() {
        let indicator = app.otherElements["connectionStatus"]
        XCTAssertTrue(indicator.waitForExistence(timeout: 5))
    }

    // MARK: - Start / Stop Toggle

    func testStartButtonToggles() {
        let toggleButton = app.buttons["feedToggle"]
        XCTAssertTrue(toggleButton.waitForExistence(timeout: 5))

        toggleButton.tap()

        let stopButton = app.buttons["feedToggle"]
        XCTAssertTrue(stopButton.waitForExistence(timeout: 5))
        XCTAssertEqual(stopButton.label, "Stop")

        stopButton.tap()

        let startButton = app.buttons["feedToggle"]
        XCTAssertTrue(startButton.waitForExistence(timeout: 5))
        XCTAssertEqual(startButton.label, "Start")
    }

    // MARK: - Navigation

    func testBackNavigationFromDetail() {
        let aaplText = app.staticTexts["AAPL"]
        XCTAssertTrue(aaplText.waitForExistence(timeout: 5))

        aaplText.tap()

        let detailView = app.scrollViews["symbolDetailView"]
        XCTAssertTrue(detailView.waitForExistence(timeout: 5))

        let backButton = app.navigationBars.buttons.firstMatch
        XCTAssertTrue(backButton.waitForExistence(timeout: 5))
        backButton.tap()

        let feedNavBar = app.navigationBars["Price Feed"]
        XCTAssertTrue(feedNavBar.waitForExistence(timeout: 5))
    }

    // MARK: - List Scrolling

    func testFeedListIsScrollable() {
        let list = app.collectionViews.firstMatch
        XCTAssertTrue(list.waitForExistence(timeout: 5))

        list.swipeUp()

        // After scrolling, some bottom symbols should be visible
        let anySymbolExists = app.staticTexts["ORCL"].waitForExistence(timeout: 5)
            || app.staticTexts["COST"].exists
            || app.staticTexts["AVGO"].exists
        XCTAssertTrue(anySymbolExists)
    }
}
