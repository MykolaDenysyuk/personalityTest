//
//  PTServices.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/13/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import Foundation


protocol PTService {}

class PTServices {
    
    private static var services = [String: PTService]()
    
    private init() {}
    
    static func setService(_ newService: PTService) {
        services[serviceName(type: type(of: newService))] = newService
    }
    
    static func getService<T>() -> T {
        if let service = services[serviceName(type: T.self)] as? T {
            return service
        }
        
        fatalError("service \(T.self) has not been registered yet")
    }
    
    fileprivate static func serviceName(type: Any.Type) -> String {
        return "\(type)"
    }
}
