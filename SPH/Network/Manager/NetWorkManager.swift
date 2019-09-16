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
  func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
  func resume()
}

extension URLSession: URLSessionProtocol {
  func dataTask(with request: URLRequest, completionHandler: @escaping URLSession.DataTaskResult) -> URLSessionDataTaskProtocol {
    return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    
  }
}
extension URLSessionDataTask: URLSessionDataTaskProtocol {
}


class NetWorkManager: NSObject {
  static var sharedManager = NetWorkManager()
  private let session: URLSessionProtocol?
  private var sessionDataTask: URLSessionDataTaskProtocol?
  private var apiServiceProvider: APIServiceProvider?
  
  init(session: URLSessionProtocol = URLSession.shared) {
    self.session = session
    apiServiceProvider = APIServiceProvider()
  }
  
  func getData(route: Route, queryParam: [String: String]?, completion: @escaping (Data?, Error?) -> Void) {
    let request = apiServiceProvider?.getRequest(route: route, requestType: RequestType.GET, queryParam: queryParam)
    guard let req = request else {
      return
    }
    
    sessionDataTask = self.session?.dataTask(with: req as URLRequest, completionHandler: { (data, response, error) in
      // here parse response
      if let data = data {
          completion(data, nil)
      }
    })
    sessionDataTask?.resume()
  }
  
}
