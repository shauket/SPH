//
//  Data.swift
//  SPH
//
//  Created by Muhammad, Shauket | RASIA on 18/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import Foundation
extension Data {
    
    mutating func writeToFile(withName name: String) {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent(name) {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                print("FILE AVAILABLE")
                let existing_data = try! String(contentsOfFile: filePath).data(using: .utf8)
                if let data = existing_data {
                    
                    let currentData = try! JSONDecoder().decode([Record].self, from: self)
                    let previous = try! JSONDecoder().decode([Record].self, from: data)
                    let finalData = currentData + previous
                    let jsonData = try! JSONEncoder().encode(finalData)
                    flushFile(pathComponent) // remove all content from file
                    try! jsonData.write(to: pathComponent , options: .atomicWrite)
                }
            } else {
                print("FILE NOT AVAILABLE")
                do {
                    let pathComponent = url.appendingPathComponent(name)
                    try write(to: pathComponent as! URL, options: .atomicWrite)
                } catch {
                    print(error)
                }
            }
        } else {
            print("FILE PATH NOT AVAILABLE")
        }
    }
    
    func flushFile(_ pathComponent: URL?) {
        let text = ""
        do {
            try text.write(to: pathComponent as! URL, atomically: false, encoding: .utf8)
        } catch {
            print(error)
        }

    }
}
