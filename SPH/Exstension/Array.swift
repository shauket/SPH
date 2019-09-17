//
//  Array.swift
//  SPH
//
//  Created by Muhammad, Shauket | RASIA on 16/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import UIKit

extension Array {
  func group<U: Hashable>(by key: (Element) -> U) -> [[Element]] {
    //keeps track of what the integer index is per group item
    var indexKeys = [U : Int]()
    
    var grouped = [[Element]]()
    for element in self {
      let key = key(element)
      
      if let ind = indexKeys[key] {
        grouped[ind].append(element)
      }
      else {
        grouped.append([element])
        indexKeys[key] = grouped.count - 1
      }
    }
    return grouped
  }
}

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
