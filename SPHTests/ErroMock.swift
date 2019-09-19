//
//  ErroMock.swift
//  SPHTests
//
//  Created by Muhammad, Shauket | RASIA on 19/9/19.
//  Copyright © 2019 Muhammad, Shauket | RASIA. All rights reserved.
//

import Foundation

enum MockedError: Int ,Error {
    case internalServer = 500
    case noInternetConnection = -901
}
