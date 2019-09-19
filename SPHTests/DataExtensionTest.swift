//
//  DataExtensionTest.swift
//  SPHTests
//
//  Created by Muhammad, Shauket | RASIA on 19/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import Foundation
import XCTest
@testable import SPH

class DataExtensionTest: XCTestCase {
    let filename: String = "testfile"
    var fileURL: URL!
    override func setUp() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent(filename) {
            fileURL = pathComponent
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                try! "".write(to: pathComponent, atomically: true, encoding: String.Encoding.utf8)
            }

        }
    }
    override func tearDown() {
        
    }
    
    func testFlushFile() {
        
        let text = ""
        try! text.write(to: fileURL as! URL, atomically: false, encoding: .utf8)
            
        
        let data = try! String(contentsOf: fileURL, encoding: .utf8)
        XCTAssertTrue(data == "")
    }
    
    func testWriteDataInFile() {
        let record = Record.init(volumeOfMobileData: "12345", quarter: "2004", id: 1)
        let data = try! JSONEncoder().encode(record)
        XCTAssertNoThrow(try! data.write(to: fileURL, options: .atomicWrite))
    }
    
    func testReadingDataFromFile() {
        let record = Record.init(volumeOfMobileData: "12345", quarter: "2004", id: 1)
        let data = try! JSONEncoder().encode(record)
        try! data.write(to: fileURL, options: .atomicWrite)
        let fileData = try! String(contentsOf: fileURL, encoding: .utf8).data(using: .utf8)
        XCTAssertNoThrow(fileData)
        let fileRecord = try! JSONDecoder().decode(Record.self, from: fileData!)
        XCTAssertEqual(fileRecord.volumeOfMobileData, record.volumeOfMobileData)
        XCTAssertEqual(fileRecord.quarter, record.quarter)
        XCTAssertEqual(fileRecord.id, record.id)
    }
}
