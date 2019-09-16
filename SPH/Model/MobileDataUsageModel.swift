//
//  MobileDataUsageModel.swift
//  SPH
//
//  Created by Muhammad, Shauket | RASIA on 16/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import UIKit

// MARK: - Root
struct MobileDataUsageModel: Codable {
  let help: String
  let result: Result
}

struct Result: Codable{
  let resourceID: String
  let fields: [Field]
  let records: [Record]
  let links: Links
  let limit, total: Int
  
  enum CodingKeys: String, CodingKey {
    case resourceID = "resource_id"
    case fields, records
    case links = "_links"
    case limit, total
  }
}

// MARK: - Field
struct Field: Codable {
  let type, id: String
}

// MARK: - Links
struct Links: Codable {
  let start, next: String
}

// MARK: - Record
struct Record: Codable {
  let volumeOfMobileData, quarter: String
  let id: Int
  var year: String {
    return self.quarter.components(separatedBy: "-").first ?? ""
  }
  var quarterStr: String {
    return self.quarter.components(separatedBy: "-").last ?? ""
  }
  enum CodingKeys: String, CodingKey {
    case volumeOfMobileData = "volume_of_mobile_data"
    case quarter
    case id = "_id"
  }
}

