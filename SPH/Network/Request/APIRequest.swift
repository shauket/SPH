//
//  APIRequest.swift
//  SPH
//
//  Created by Muhammad, Shauket | RASIA on 16/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import Foundation

enum RequestType: String {
  case GET = "GET"
  case POST = "POST" // we are not posting data for this project. Define here other types
}

class APIRequest: EndPoints {
  var baseURL: NSURL?
  
  var route: Route
  
  var body: [String : Any]?
  
  var headers: [String : String]?
  
  var queryParam: [String : String]?
  
  var method: RequestType
  
  init(route: Route, method: RequestType, queryParam: [String: String]? = nil, headers: [String : String]? = nil, body: [String : Any]? = nil) {
    self.baseURL = NSURL.init(string: NetWorkConstants.baseURL.description)
    self.route = route
    self.method = method
    self.queryParam = queryParam
    self.headers = headers
    self.body = body
  }
  
  func buildRequest() -> NSURLRequest? {
    guard let baseURL = self.baseURL else {
      return nil
    }
    
    guard let URLComponents = NSURLComponents(url: baseURL as URL, resolvingAgainstBaseURL: true) else { return nil }
    URLComponents.path = (URLComponents.path ?? "") + self.route.description
    guard let URL = URLComponents.url else { return nil }
    
    // Add qurey param with url
    var reqURL: URL = URL
    if let queryParam = self.queryParam {
      for (key, value) in queryParam {
        reqURL = reqURL.appending(key, value: value)
      }
    }
    
    // Add body in request
    let request = NSMutableURLRequest(url: reqURL)
    request.httpMethod = self.method.rawValue
    if let body = self.body {
      request.httpBody = try! JSONSerialization.data(withJSONObject: body, options: [])
    }

    // add header
    
    if let headers = self.headers {
      for (key, value) in headers {
        request.setValue(value, forHTTPHeaderField: key)
      }
    }
    return request
  }
  
}


extension URL {
  
  func appending(_ queryItem: String, value: String?) -> URL {
    
    guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
    
    // Create array of existing query items
    var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
    
    // Create query item
    let queryItem = URLQueryItem(name: queryItem, value: value)
    
    // Append the new query item in the existing query items array
    queryItems.append(queryItem)
    
    // Append updated query items array in the url component object
    urlComponents.queryItems = queryItems
    
    // Returns the url from new url components
    return urlComponents.url!
  }
}

