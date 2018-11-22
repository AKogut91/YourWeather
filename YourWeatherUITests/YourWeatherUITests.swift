//
//  YourWeatherUITests.swift
//  YourWeatherUITests
//
//  Created by AlexanderKogut on 11/17/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import XCTest

class YourWeatherUITests: XCTestCase {

    let app = XCUIApplication()

    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        

    }

    func testNavigationBarsButton() {
        XCTAssert(app.navigationBars["Cities"].exists)
        app.navigationBars["Cities"].buttons["Add"].tap()
       // XCTAssert(app.navigationBars["Select City"].exists)
        app.navigationBars["Select City"].buttons["Cities"].tap()
        app.navigationBars.buttons.element(boundBy: 1).tap()
        
    }
    
}
