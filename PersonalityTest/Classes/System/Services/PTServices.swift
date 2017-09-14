//
//  PTServices.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/13/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import Foundation


protocol PTService {
	var serviceName: String {get}
}

class PTServices {
    
    private static var services = [String: PTService]()
    
    private init() {}
    
    static func setService(_ newService: PTService) {
        services[newService.serviceName] = newService
    }
    
	static func getService<T>(named: String) -> T {
        if let service = services[named] as? T {
            return service
        }
        
        fatalError("service \(T.self) has not been registered yet")
    }
}
