//
//  NetWorkConstants.swift
//  SPH
//
//  Created by Muhammad, Shauket | RASIA on 16/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import UIKit

enum NetWorkConstants: CustomStringConvertible {
  case baseURL
  case resourceId
  
  var description: String {
    switch self {
    case .baseURL:
      return "https://data.gov.sg/api/"
    case .resourceId:
      return "a807b7ab-6cad-4aa6-87d0-e283a7353a0f"
    }
  }
}
