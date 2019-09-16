//
//  NetWorkManager.swift
//  SPH
//
//  Created by Muhammad, Shauket | RASIA on 16/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
  typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
  func dataTask(with request: NSURLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
  func resume()
}

extension URLSession: URLSessionProtocol {
  func dataTask(with request: NSURLRequest, completionHandler: @escaping URLSession.DataTaskResult) -> URLSessionDataTaskProtocol {
    return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTaskProtocol
  }
}
extension URLSessionDataTask: URLSessionDataTaskProtocol {}


class NetWorkManager: NSObject {
  private let session: URLSessionProtocol?
  private var apiServiceProvider: APIServiceProvider?
  
  init(session: URLSessionProtocol = URLSession.shared) {
    self.session = session
    apiServiceProvider = APIServiceProvider()
  }
  
  func getData(route: Route, queryParam: [String: String]?) {
    let request = apiServiceProvider?.getRequest(route: route, requestType: RequestType.GET, queryParam: queryParam)
    guard let req = request else {
      return
    }
    
    self.session?.dataTask(with: req, completionHandler: { (data, response, error) in
      // here parse response
    })
  }
  
}
