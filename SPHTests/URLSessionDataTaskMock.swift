//
//  URLSessionDataTaskMock.swift
//  SPHTests
//
//  Created by Muhammad, Shauket | RASIA on 18/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import Foundation
@testable import SPH

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    // We override the 'resume' method and simply call our closure
    // instead of actually resuming any task.
    override func resume() {
        closure()
    }

}
