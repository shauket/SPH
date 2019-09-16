//
//  APIServiceProvider.swift
//  SPH
//
//  Created by Muhammad, Shauket | RASIA on 16/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import UIKit

class APIServiceProvider: NSObject {
  var apiRequest: APIRequest?
  func getRequest(route: Route, requestType: RequestType, queryParam: [String: String]? = nil, body: [String : Any]? = nil) -> NSURLRequest? {
    let headers = ["Content-Type" : "application/json"]
    apiRequest = APIRequest(route: route, method: requestType, queryParam: queryParam, headers: headers, body: body)
    return apiRequest?.buildRequest()
  }
}
