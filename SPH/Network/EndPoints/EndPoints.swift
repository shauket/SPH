//
//  EndPoints.swift
//  SPH
//
//  Created by Muhammad, Shauket | RASIA on 16/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import UIKit

protocol EndPoints {
  var baseURL: NSURL? { get set }
  var method: RequestType { get set }
  var route: Route { get set }
  var body: [String : Any]? { get set }
  var headers: [String : String]? { get set }
  var queryParam: [String : String]? { get set }
}

