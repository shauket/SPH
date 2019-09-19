//
//  NetWorkManager.swift
//  SPH
//
//  Created by Muhammad, Shauket | RASIA on 16/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import Foundation

class NetWorkManager: NSObject {
  static var sharedManager = NetWorkManager()
    private let session: URLSession?
  private var apiServiceProvider: APIServiceProvider?
  
  init(session: URLSession = URLSession.shared) {
    self.session = session
    apiServiceProvider = APIServiceProvider()
  }
  
  func getData(route: Route, queryParam: [String: String]?, completion: @escaping (Data?, Error?) -> Void) {
    let request = apiServiceProvider?.getRequest(route: route, requestType: RequestType.GET, queryParam: queryParam)
    guard let req = request else {
      return
    }
    
    self.session?.dataTask(with: req as URLRequest, completionHandler: { (data, _, error) in
        
        if let data = data {
            completion(data, nil)
        } else {
            completion(nil, error)
        }
    })
    .resume()
  }
  
}
