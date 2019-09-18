//
//  LocalDataRepositery.swift
//  SPH
//
//  Created by Muhammad, Shauket | RASIA on 18/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import Foundation

class LocalDataRepositery {
    
    static func getLocalData() -> Data? {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent("mobileData") {
            do {
                let data = try String(contentsOf: pathComponent, encoding: .utf8).data(using: .utf8)
                return data
            }
            catch {
                print(error)
            }
        }
        
        return nil
    }
}
