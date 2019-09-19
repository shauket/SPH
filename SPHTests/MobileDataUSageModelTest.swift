//
//  MobileDataUSageModelTest.swift
//  SPHTests
//
//  Created by Muhammad, Shauket | RASIA on 19/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import Foundation
import XCTest
@testable import SPH

class MobileDataUsageModelTest: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDataIsPopuplatingInModel() {
        let sampleResponse = """
{"help": "https://data.gov.sg/api/3/action/help_show?name=datastore_search", "success": true, "result": {"resource_id": "a807b7ab-6cad-4aa6-87d0-e283a7353a0f", "fields": [{"type": "int4", "id": "_id"}, {"type": "text", "id": "quarter"}, {"type": "numeric", "id": "volume_of_mobile_data"}], "records": [{"volume_of_mobile_data": "0.000384", "quarter": "2004-Q3", "_id": 1}], "_links": {"start": "/api/action/datastore_search?limit=1&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f", "next": "/api/action/datastore_search?offset=1&limit=1&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"}, "offset": 1, "limit": 1, "total": 59}}
"""
        let jsonData = sampleResponse.data(using: .utf8)
        
        XCTAssertNotNil(jsonData)
        
        let model = try! JSONDecoder().decode(MobileDataUsageModel.self, from: jsonData!)
        XCTAssertNotNil(model)
    }
    
    //quarter: "2004-Q1"
    func testYearSpllitingToComponents() {
        
        let year = "2004"
        let quarter = "Q3"
        let sampleResponse = """
{"help": "https://data.gov.sg/api/3/action/help_show?name=datastore_search", "success": true, "result": {"resource_id": "a807b7ab-6cad-4aa6-87d0-e283a7353a0f", "fields": [{"type": "int4", "id": "_id"}, {"type": "text", "id": "quarter"}, {"type": "numeric", "id": "volume_of_mobile_data"}], "records": [{"volume_of_mobile_data": "0.000384", "quarter": "2004-Q3", "_id": 1}], "_links": {"start": "/api/action/datastore_search?limit=1&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f", "next": "/api/action/datastore_search?offset=1&limit=1&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"}, "offset": 1, "limit": 1, "total": 59}}
"""
        let jsonData = sampleResponse.data(using: .utf8)
        let model = try! JSONDecoder().decode(MobileDataUsageModel.self, from: jsonData!)
        XCTAssertEqual(model.result.records.first?.year, year)
        XCTAssertEqual(model.result.records.first?.quarterStr, quarter)
    }
}
