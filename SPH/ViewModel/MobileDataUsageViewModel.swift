//
//  MobileDataUsageViewModel.swift
//  SPH
//
//  Created by Muhammad, Shauket | RASIA on 16/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import Foundation
import Network

class MobileDataUsageViewModel: NSObject {
    private let data_limit_per_request = 10
    private var mobileUsageData = [[Record]]()
    private var offset: Int = 0
    private var limit: Int = 0
    private var total: Int = 0
    private var isOffline: Bool = false
    
    func getMobileUsageData(completion: @escaping (Error?) -> Void) {
        
        NetWorkManager.sharedManager.getData(route: Route.search, queryParam: ["resource_id" : NetWorkConstants.resourceId.description,"offset": String(self.offset), "limit": String(data_limit_per_request)]) { (data, error) in
            if let data = data {
                self.isOffline = false
                self.parseJsonData(data)
                completion(nil)
                
            } else { // in case offline
                if let err = error as? URLError, err.code  == URLError.Code.notConnectedToInternet {
                    print("internet error")
                    self.isOffline = true
                    if let data = LocalDataRepositery.getLocalData() {
                        self.parseOffLineData(data)
                        completion(nil)
                    }
                }
            }
        }
    }

    func populateData(_ records: [Record]) {
        if self.mobileUsageData.count > 0 && !isOffline {
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

extension MobileDataUsageViewModel {
    func parseJsonData(_ data: Data) {
        do {
            let mobileData = try JSONDecoder().decode(MobileDataUsageModel.self, from: data)
            self.limit = mobileData.result.limit
            self.offset = mobileData.result.offset ?? 0
            self.total = mobileData.result.total
            self.populateData(mobileData.result.records)
            var jsonData = try JSONEncoder().encode(mobileData.result.records)
            jsonData.writeToFile(withName: "mobileData")

        } catch {
            print(error)
        }
    }
    
    func parseOffLineData(_ data: Data) {
        do {
            var records = try JSONDecoder().decode([Record].self, from: data)
            self.offset = records.count
            self.total = 59;
            records.sort{ $0.year < $1.year} // show sorted data
            self.populateData(records)
        } catch {
            print(error)
        }
    }
}
