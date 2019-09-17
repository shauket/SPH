//
//  MobileDataUsageViewModel.swift
//  SPH
//
//  Created by Muhammad, Shauket | RASIA on 16/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import UIKit

class MobileDataUsageViewModel: NSObject {
    private let limit_per_cycle = 10
    private var mobileUsageData: [[Record]]?
    
    
    func getMobileUsageData(completion: @escaping (Error?) -> Void) {
    NetWorkManager.sharedManager.getData(route: Route.search, queryParam: ["resource_id" : NetWorkConstants.resourceId.description, "limit": String(limit_per_cycle)]) { (data, error) in
          if let data = data {
            do {
                let mobileData = try JSONDecoder().decode(MobileDataUsageModel.self, from: data)
                self.populateData(records: mobileData.result.records)
                completion(nil)
            } catch {
                completion(error)
            }
            
            }
        }
    }

    func populateData(records: [Record]) {
        self.mobileUsageData = records.group { $0.year }
    }
    
    func getNumberOfSections() -> Int {
        return self.mobileUsageData?.count ?? 0
    }
    
    func getNumberOfRows(_ section: Int) -> Int {
        return self.mobileUsageData?[section].count ?? 0
    }
    
    func getRecordForRow(indexPath: IndexPath) -> (Record?, Bool) {
        let section = indexPath.section
        let row = indexPath.row
        let record = self.mobileUsageData?[section][row]
        let min = self.showDecreaseInDataImage(indexPath)
        
        return (record, record?.volumeOfMobileData.toDouble() == min)
    }
    
    func getHeaderTitle(section: Int) -> String? {
        return self.mobileUsageData?[section].first?.year
    }
    // quarter image
    func showDecreaseInDataImage(_ indexPath: IndexPath) -> Double? {
        let array = self.mobileUsageData?[indexPath.section]
        let min: Double? = array!.first!.volumeOfMobileData.toDouble()
        for index in 0..<array!.count {
            let data = array![index]
            
            let volume: Double? = data.volumeOfMobileData.toDouble()
            if let volume =  volume, var min = min, volume < min {
                min = volume
            }
        }
        return min
    }
}
