//
//  PTNetworkManager.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/14/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import Foundation


class PTNetworkManager: PTNetworkService {
    
    func get(path: String, onComplete block: @escaping PTNetworkResponseCallback) {
        if path == "quesitions" {
            DispatchQueue.global(qos: .background).async {
                let filename = "personality_test"
                let filetype = "json"
                if let filepath = Bundle.main.path(forResource: filename, ofType: filetype) {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: filepath),
                                            options: .dataReadingMapped)
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                        if let json = json as? [String: Any] {
                            block(.success(json))
                        } else {
                            let error = NSError(domain: "PTNetworkManager", code: -1,
                                                userInfo: [NSLocalizedDescriptionKey: "another json format is expected"])
                            block(.failure(error))
                        }
                    }
                    catch {
                        block(.failure(error))
                    }
                    
                } else {
                    let error = NSError(domain: "PTNetworkManager", code: -1,
                                        userInfo: [NSLocalizedDescriptionKey: "can't find the json file"])
                    block(.failure(error))
                }
            }
        }
        else {
            let error = NSError(domain: "PTNetworkManager", code: -1,
                                userInfo: [NSLocalizedDescriptionKey: "it's a fake network manager after all"])
            block(.failure(error))
        }
    }
    
    func post(path: String, parameters: [String : String], onComplete block: @escaping PTNetworkResponseCallback) {
        let error = NSError(domain: "PTNetworkManager", code: -1,
                            userInfo: [NSLocalizedDescriptionKey: "this method is not implemented"])
        block(.failure(error))
    }
    
}
