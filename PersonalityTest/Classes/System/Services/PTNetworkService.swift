//
//  PTNetworkService.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/13/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import Foundation

enum PTNetworkResponse {
    case success([String: Any])
    case failure(Error)
}

typealias PTNetworkResponseCallback = (PTNetworkResponse) -> ()

protocol PTNetworkService: PTService {
    func get(path: String,
             onComplete block: PTNetworkResponseCallback)
    func post(path: String,
              parameters: [String: String],
              onComplete block: PTNetworkResponseCallback)
}


extension PTServices {
    static var network: PTNetworkService {
        let ret: PTNetworkService = getService()
        return ret
    }
}


