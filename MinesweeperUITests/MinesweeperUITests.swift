//
//  MinesweeperUITests.swift
//  MinesweeperUITests
//
//  Created by Raúl Carrancá on 24/08/22.
//

import XCTest

class MinesweeperUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertFalse(app.staticTexts["1"].exists, "Expected all Locations to be 0 before first location is opned")
        XCTAssertFalse(app.staticTexts["💣"].exists, "Expected no Location to contain a bomb")
        app.staticTexts["0"].firstMatch.tap()
        XCTAssert(app.staticTexts["💣"].exists, "Expected at least one Location to contain a bomb")
        app.staticTexts["💣"].firstMatch.press(forDuration: 2)
        app.staticTexts["💣"].firstMatch.tap()
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
