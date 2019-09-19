//
//  MobileDataUsageViewModelTests.swift
//  SPHTests
//
//  Created by Muhammad, Shauket | RASIA on 19/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import Foundation
import XCTest
@testable import SPH

class MobileDataUsageViewModelTests: XCTestCase {
    var mobileDataUsageViewModel: MobileDataUsageViewModel!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mobileDataUsageViewModel = MobileDataUsageViewModel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSucessfullInitOfViewModel() {
        XCTAssertNotNil(mobileDataUsageViewModel, "View model succssfully initialize")
    }
    
    func testMobileRecordDat2DArrayInitallyEmpty() {
        XCTAssertEqual(mobileDataUsageViewModel.getRecords().count, 0)
    }
    
    func testInitailCanSendRequest() {
        XCTAssertEqual(mobileDataUsageViewModel.canSendRequest(), false)
    }
    
    func testDataParsing() {
        let sampleResponse = """
{"help": "https://data.gov.sg/api/3/action/help_show?name=datastore_search", "success": true, "result": {"resource_id": "a807b7ab-6cad-4aa6-87d0-e283a7353a0f", "fields": [{"type": "int4", "id": "_id"}, {"type": "text", "id": "quarter"}, {"type": "numeric", "id": "volume_of_mobile_data"}], "records": [{"volume_of_mobile_data": "0.000384", "quarter": "2004-Q3", "_id": 1}], "_links": {"start": "/api/action/datastore_search?limit=1&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f", "next": "/api/action/datastore_search?offset=1&limit=1&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"}, "offset": 1, "limit": 1, "total": 59}}
"""
        let jsonData = sampleResponse.data(using: .utf8)
        
        XCTAssertNotNil(jsonData)
        
        let model = try! JSONDecoder().decode(MobileDataUsageModel.self, from: jsonData!)
        
        XCTAssertNotNil(model)
        XCTAssertNotNil(model.result.records)
        XCTAssertEqual(model.result.records.count, 1)
        XCTAssertEqual(model.result.offset, 1)
        XCTAssertEqual(model.result.limit, 1)
        XCTAssertEqual(model.result.total, 59)
    }
    
    func testMobileDataArrayAfterParsing() {
        let sampleResponse = """
{"help": "https://data.gov.sg/api/3/action/help_show?name=datastore_search", "success": true, "result": {"resource_id": "a807b7ab-6cad-4aa6-87d0-e283a7353a0f", "fields": [{"type": "int4", "id": "_id"}, {"type": "text", "id": "quarter"}, {"type": "numeric", "id": "volume_of_mobile_data"}], "records": [{"volume_of_mobile_data": "0.000384", "quarter": "2004-Q3", "_id": 1}], "_links": {"start": "/api/action/datastore_search?limit=1&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f", "next": "/api/action/datastore_search?offset=1&limit=1&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"}, "offset": 1, "limit": 1, "total": 59}}
"""
        let jsonData = sampleResponse.data(using: .utf8)
        
        XCTAssertNotNil(jsonData)
        
        let model = try! JSONDecoder().decode(MobileDataUsageModel.self, from: jsonData!)
        
        mobileDataUsageViewModel.populateData(model.result.records)
        XCTAssertTrue(mobileDataUsageViewModel.getRecords().count > 0)
    }
    
    func testMobileDataArrayContainCorrectRecord() {
        let sampleResponse = """
{"help": "https://data.gov.sg/api/3/action/help_show?name=datastore_search", "success": true, "result": {"resource_id": "a807b7ab-6cad-4aa6-87d0-e283a7353a0f", "fields": [{"type": "int4", "id": "_id"}, {"type": "text", "id": "quarter"}, {"type": "numeric", "id": "volume_of_mobile_data"}], "records": [{"volume_of_mobile_data": "0.000384", "quarter": "2004-Q3", "_id": 1}], "_links": {"start": "/api/action/datastore_search?limit=1&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f", "next": "/api/action/datastore_search?offset=1&limit=1&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"}, "offset": 1, "limit": 1, "total": 59}}
"""
        let jsonData = sampleResponse.data(using: .utf8)
        
        XCTAssertNotNil(jsonData)
        
        let model = try! JSONDecoder().decode(MobileDataUsageModel.self, from: jsonData!)
        let records = model.result.records
        mobileDataUsageViewModel.populateData(model.result.records)
        XCTAssertEqual(records.count, mobileDataUsageViewModel.getRecords().count)
        XCTAssertTrue(records.first?.volumeOfMobileData == mobileDataUsageViewModel.getRecords().first!.first!.volumeOfMobileData)
        XCTAssertTrue(records.first?.id == mobileDataUsageViewModel.getRecords().first!.first!.id)
        XCTAssertTrue(records.first?.year == mobileDataUsageViewModel.getRecords().first!.first!.year)
        
    }
    
    func testSectionCountForList() {
        let sampleResponse = """
{"help": "https://data.gov.sg/api/3/action/help_show?name=datastore_search", "success": true, "result": {"resource_id": "a807b7ab-6cad-4aa6-87d0-e283a7353a0f", "fields": [{"type": "int4", "id": "_id"}, {"type": "text", "id": "quarter"}, {"type": "numeric", "id": "volume_of_mobile_data"}], "records": [{"volume_of_mobile_data": "0.000384", "quarter": "2004-Q3", "_id": 1}], "_links": {"start": "/api/action/datastore_search?limit=1&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f", "next": "/api/action/datastore_search?offset=1&limit=1&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"}, "offset": 1, "limit": 1, "total": 59}}
"""
        let jsonData = sampleResponse.data(using: .utf8)
        
        XCTAssertNotNil(jsonData)
        
        let model = try! JSONDecoder().decode(MobileDataUsageModel.self, from: jsonData!)
        mobileDataUsageViewModel.populateData(model.result.records)
        XCTAssertEqual(mobileDataUsageViewModel.getRecords().count, 1)        
    }
    
    func testRowsCountForList() {
        let sampleResponse = """
{"help": "https://data.gov.sg/api/3/action/help_show?name=datastore_search", "success": true, "result": {"resource_id": "a807b7ab-6cad-4aa6-87d0-e283a7353a0f", "fields": [{"type": "int4", "id": "_id"}, {"type": "text", "id": "quarter"}, {"type": "numeric", "id": "volume_of_mobile_data"}], "records": [{"volume_of_mobile_data": "0.000384", "quarter": "2004-Q3", "_id": 1}], "_links": {"start": "/api/action/datastore_search?limit=1&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f", "next": "/api/action/datastore_search?offset=1&limit=1&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"}, "offset": 1, "limit": 1, "total": 59}}
"""
        let jsonData = sampleResponse.data(using: .utf8)
        
        XCTAssertNotNil(jsonData)
        
        let model = try! JSONDecoder().decode(MobileDataUsageModel.self, from: jsonData!)
        mobileDataUsageViewModel.populateData(model.result.records)
        XCTAssertEqual(mobileDataUsageViewModel.getRecords().first!.count, 1)
    }
    
    func testHeaderTitles() {
        let sampleResponse = """
{"help": "https://data.gov.sg/api/3/action/help_show?name=datastore_search", "success": true, "result": {"resource_id": "a807b7ab-6cad-4aa6-87d0-e283a7353a0f", "fields": [{"type": "int4", "id": "_id"}, {"type": "text", "id": "quarter"}, {"type": "numeric", "id": "volume_of_mobile_data"}], "records": [{"volume_of_mobile_data": "0.000384", "quarter": "2004-Q3", "_id": 1}], "_links": {"start": "/api/action/datastore_search?limit=1&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f", "next": "/api/action/datastore_search?offset=1&limit=1&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"}, "offset": 1, "limit": 1, "total": 59}}
"""
        let jsonData = sampleResponse.data(using: .utf8)
        
        XCTAssertNotNil(jsonData)
        
        let model = try! JSONDecoder().decode(MobileDataUsageModel.self, from: jsonData!)
        mobileDataUsageViewModel.populateData(model.result.records)
        XCTAssertEqual(mobileDataUsageViewModel.getHeaderTitle(section: 0), "2004")
    }
}
