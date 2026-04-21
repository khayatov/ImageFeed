//
//  ImageFeedTestsUILaunchTests.swift
//  ImageFeedTestsUI
//
//  Created by Andrey Khayatov on 25.01.26.
//

import XCTest

final class ImageFeedTestsUILaunchTests: XCTestCase {
    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
