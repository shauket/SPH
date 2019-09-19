//
//  SPHTests.swift
//  SPHTests
//
//  Created by Muhammad, Shauket | RASIA on 15/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import XCTest
@testable import SPH

class SPHTests: XCTestCase {
    var apiRequest: APIRequest!
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

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testBuildRequest() {
        let params = ["resource_id" : "a807b7ab-6cad-4aa6-87d0-e283a7353a0f","offset": "0", "limit": "10"]
        let headers = ["Content-Type" : "application/json"]
        apiRequest = APIRequest(route: Route.search, method: RequestType.GET, queryParam: params, headers: headers)
        let request = apiRequest.buildRequest()

        XCTAssertEqual(apiRequest.route.description, "datastore_search")
        XCTAssertEqual(apiRequest.baseURL?.absoluteString, NetWorkConstants.baseURL.description)
        XCTAssertEqual(request?.allHTTPHeaderFields?.count, 1)
        XCTAssertEqual(request?.httpMethod, "GET")
        XCTAssertNotNil(request?.allHTTPHeaderFields)
        XCTAssertNotNil(apiRequest.queryParam, "Param is nil")
        XCTAssertTrue((request?.url?.query?.contains("a807b7ab-6cad-4aa6-87d0-e283a7353a0f"))!)
        XCTAssertTrue((request?.url?.query?.contains("offset"))!)
        XCTAssertTrue((request?.url?.query?.contains("10"))!)
        XCTAssertTrue((request?.url?.query?.contains("0"))!)
    }
}
