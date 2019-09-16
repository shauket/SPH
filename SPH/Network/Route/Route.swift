//
//  Route.swift
//  SPH
//
//  Created by Muhammad, Shauket | RASIA on 16/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import Foundation

enum Route: CustomStringConvertible {
  case search
  
  var description: String {
    switch self {
    case .search:
      return "datastore_search"
    }
  }
}

