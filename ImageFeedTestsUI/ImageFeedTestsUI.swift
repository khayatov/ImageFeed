//
//  ImageFeedTestsUI.swift
//  ImageFeedTestsUI
//
//  Created by Andrey Khayatov on 25.01.26.
//

import XCTest

final class ImageFeedTestsUI: XCTestCase {
    private let app = XCUIApplication()
    
    override func setUpWithError() throws {
        app.launchArguments = ["TestsUI"]
        continueAfterFailure = false
        app.launch()
    }
    
    func testAuth() throws {
        let authButton = app.buttons["Authenticate"]
        
        if !authButton.exists {
            let tabBar = app.tabBars.buttons.element(boundBy: 1)
            XCTAssertTrue(tabBar.waitForExistence(timeout: 10))
            tabBar.tap()
            
            let logoutButton = app.buttons["logoutButton"]
            XCTAssertTrue(logoutButton.waitForExistence(timeout: 10))
            logoutButton.tap()
            
            let yesButton = app.alerts["Пока, пока!"].buttons["Да"]
            XCTAssertTrue(yesButton.waitForExistence(timeout: 10))
            yesButton.tap()
            
            XCTAssertTrue(authButton.waitForExistence(timeout: 10))
        }
        
        authButton.tap()
        
        let webView = app.webViews["authWebView"]
        XCTAssertTrue(webView.waitForExistence(timeout: 5))
        
        let window = webView.coordinate(withNormalizedOffset: CGVector(dx: 0.1, dy: 0.1))
        
        let loginTextField = webView.descendants(matching: .textField).element
        XCTAssertTrue(loginTextField.waitForExistence(timeout: 5))
        
        loginTextField.tap()
        loginTextField.typeText("")
        window.tap()
        webView.swipeUp()
        
        let passwordTextField = webView.descendants(matching: .secureTextField).element
        XCTAssertTrue(passwordTextField.waitForExistence(timeout: 5))
        
        passwordTextField.tap()
        passwordTextField.typeText("")
        window.tap()
        webView.swipeUp()
        
        webView.buttons["Login"].tap()
        
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
    }
    
    func testFeed() throws {
        let tablesQuery = app.tables
        
        sleep(5)
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 1)
        cell.swipeUp()
        
        sleep(2)
        
        let cellToLike = tablesQuery.children(matching: .cell).element(boundBy: 1)
        
        cellToLike.buttons["likeButton"].tap()
        sleep(2)
        cellToLike.buttons["likeButton"].tap()
        sleep(2)
        
        cellToLike.tap()
        
        sleep(60)
        
        let image = app.scrollViews.images.element(boundBy: 0)
        image.pinch(withScale: 3, velocity: 1)
        image.pinch(withScale: 0.5, velocity: -1)
        sleep(2)
        let navBackButtonWhiteButton = app.buttons["backButton"]
        navBackButtonWhiteButton.tap()
        sleep(2)
    }
    
    func testProfile() throws {
        sleep(5)
        let tabBar = app.tabBars.buttons.element(boundBy: 1)
        XCTAssertTrue(tabBar.waitForExistence(timeout: 10))
        tabBar.tap()
        
        XCTAssertTrue(app.staticTexts["Andrey Khayatov"].exists)
        XCTAssertTrue(app.staticTexts["@khayatov"].exists)
        
        let logoutButton = app.buttons["logoutButton"]
        XCTAssertTrue(logoutButton.waitForExistence(timeout: 10))
        logoutButton.tap()
        
        let yesButton = app.alerts["Пока, пока!"].buttons["Да"]
        XCTAssertTrue(yesButton.waitForExistence(timeout: 10))
        yesButton.tap()
        sleep(5)
    }
}
