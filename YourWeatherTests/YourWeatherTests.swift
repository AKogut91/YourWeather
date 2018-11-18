//
//  YourWeatherTests.swift
//  YourWeatherTests
//
//  Created by AlexanderKogut on 11/17/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import XCTest
@testable import YourWeather

class YourWeatherTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testGettingJSON() {
        
        let ex = expectation(description: "Expecting a JSON data not nil")
        
        let params = Request.params(params: ["q": "Kiev"])
        
        Request.apiRequest(link: RestAPI.Methods.cityWeather, urlParams: params) { (result) in
            
            XCTAssertNotNil(result)
            ex.fulfill()
        }
    
        waitForExpectations(timeout: 3) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }

    func testGettingJsonFromLocation() {
        
        let ex = expectation(description: "Expecting a JSON data not nil")
        
        let params = Request.params(params: ["lat": 35.50, "lon": 50.62])
        
        Request.apiRequest(link: RestAPI.Methods.locationWeather, urlParams: params)  { (result) in
            
            XCTAssertNotNil(result)
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
