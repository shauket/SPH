//
//  MobileDataUsageViewModel.swift
//  SPH
//
//  Created by Muhammad, Shauket | RASIA on 16/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import UIKit

class MobileDataUsageViewModel: NSObject {
    private let data_limit_per_request = 10
    private var mobileUsageData = [[Record]]()
    private var offset: Int = 0
    private var limit: Int = 0
    private var total: Int = 0
    
    func getMobileUsageData(completion: @escaping (Error?) -> Void) {
        
        NetWorkManager.sharedManager.getData(route: Route.search, queryParam: ["resource_id" : NetWorkConstants.resourceId.description,"offset": String(self.offset), "limit": String(data_limit_per_request)]) { (data, error) in
          if let data = data {
            do {
                let mobileData = try JSONDecoder().decode(MobileDataUsageModel.self, from: data)
                self.limit = mobileData.result.limit
                self.offset = mobileData.result.offset ?? 0
                self.total = mobileData.result.total
                self.populateData(records: mobileData.result.records)
                completion(nil)
            } catch {
                completion(error)
            }
            
            }
        }
    }

    func populateData(records: [Record]) {
        if self.mobileUsageData.count > 0 {
            var unsortedData = self.mobileUsageData.flatMap { $0 }
            unsortedData = unsortedData + records
            let groupedData = unsortedData.group { $0.year }
            self.mobileUsageData = groupedData
        } else {
            let groupedData = records.group { $0.year }
            self.mobileUsageData = groupedData
            //update offset
        }
        self.offset = self.offset + self.limit
    }
    
    func getNumberOfSections() -> Int {
        return self.mobileUsageData.count
    }
    
    func getNumberOfRows(_ section: Int) -> Int {
        return self.mobileUsageData[section].count
    }
    
    func getRecordForRow(indexPath: IndexPath) -> (Record?, Bool) {
        let section = indexPath.section
        let row = indexPath.row
        let record = self.mobileUsageData[section][row]
        let min = self.showDecreaseInDataImage(indexPath)
        
        return (record, record.volumeOfMobileData.toDouble() == min)
    }
    
    func getHeaderTitle(section: Int) -> String? {
        return self.mobileUsageData[section].first?.year
    }
    // quarter image
    func showDecreaseInDataImage(_ indexPath: IndexPath) -> Double? {
        let array = self.mobileUsageData[indexPath.section]
        let min: Double? = array.first!.volumeOfMobileData.toDouble()
        for index in 0..<array.count {
            let data = array[index]
            
            let volume: Double? = data.volumeOfMobileData.toDouble()
            if let volume =  volume, var min = min, volume < min {
                min = volume
            }
        }
        return min
    }
        
    func canSendRequest() -> Bool {
        return self.offset < total
    }
}
