//
//  PTStoryboardService.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/15/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

protocol PTStoryboardInterface {
	func instantiateViewController(withIdentifier identifier: String) -> UIViewController
}

extension UIStoryboard: PTStoryboardInterface {}

protocol PTStoryboardService: PTService {
	func storyboardWith(name: String) -> PTStoryboardInterface
}

let PTStoryboardServiceName = "PTStoryboardServiceName"

extension PTStoryboardService {
	var serviceName: String {
		return PTStoryboardServiceName
	}
	var main: PTStoryboardInterface {
		return storyboardWith(name: "Main")
	}
}

extension PTServices {
	static var storyboards: PTStoryboardService {
		return getService(named: PTStoryboardServiceName)
	}
}
