//
//  MobileDataUsageViewModel.swift
//  SPH
//
//  Created by Muhammad, Shauket | RASIA on 16/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import UIKit

class MobileDataUsageViewModel: NSObject {
  private let limit_per_cycle = 5
  private var mobileUsageData: [[Record]]?
  
  func getMobileUsageData(completion: @escaping (Error) -> Void) {
    NetWorkManager.sharedManager.getData(route: Route.search, queryParam: ["resource_id" : NetWorkConstants.resourceId.description, "limit": String(limit_per_cycle)]) { (data, error) in
      if let data = data {
        do {
          let mobileData = try JSONDecoder().decode(MobileDataUsageModel.self, from: data)
          self.populateData(records: mobileData.result.records)
        } catch {
          completion(error)
        }
        
      }
    }
  }
  
  func populateData(records: [Record]) {
    self.mobileUsageData = records.group { $0.year }
    print(mobileUsageData)
  }
}
