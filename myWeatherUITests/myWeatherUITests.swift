//
//  myWeatherUITests.swift
//  myWeatherUITests
//
//  Created by Abhir Vaidya on 29/03/17.
//  Copyright © 2017 Abhir Vaidya. All rights reserved.
//

import XCTest

class myWeatherUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearch() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        
        let app = XCUIApplication()
        
        
        let element = app.otherElements.containing(.navigationBar, identifier:"Weather App").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .other).element(boundBy: 0).children(matching: .searchField).element.tap()
        
        element.children(matching: .other).element(boundBy: 0).children(matching: .searchField).element.typeText("Pune")

        app.typeText("\n")
        
    }
    func testCitySelection()  {
        XCUIApplication().tables.children(matching: .cell).element(boundBy: 1).staticTexts["Pune"].tap()
        
    }
    func testSwipeFunctionality() {
        
        let app = XCUIApplication()
        app.tables.children(matching: .cell).element(boundBy: 1).staticTexts["Pune"].tap()
        
        let element = app.otherElements.containing(.navigationBar, identifier:"myWeather.WeatherDetailView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1)
        element.swipeLeft()
        app.navigationBars["myWeather.WeatherDetailView"].buttons["Weather App"].tap()
        
    }
}
