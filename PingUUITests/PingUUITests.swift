//
//  PingUUITests.swift
//  PingUUITests
//
//  Created by Chinthan M on 11/06/25.
//

import XCTest

final class PingUUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}

// ChatAppUITests.swift
import XCTest

final class ChatAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testSendMessageUIFlow() {
        let app = XCUIApplication()
        app.launch()

        let inputTextField = app.textFields["InputTextEditor"]
        XCTAssertTrue(inputTextField.waitForExistence(timeout: 5))
        inputTextField.tap()
        inputTextField.typeText("Hello UI Test")

        let sendButton = app.buttons["SendButton"]
        XCTAssertTrue(sendButton.exists)
        sendButton.tap()

        let sentMessage = app.staticTexts["Hello UI Test"]
        XCTAssertTrue(sentMessage.waitForExistence(timeout: 2.0))
    }

}
