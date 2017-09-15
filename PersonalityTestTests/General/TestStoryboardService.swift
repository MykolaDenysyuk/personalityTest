//
//  TestStoryboardService.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/15/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

class TestStoryboard: PTStoryboardInterface {
	var controllers = [String: UIViewController]()
	var controller = UIViewController()
	func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
		if let vc = controllers[identifier] {
			return vc
		}
		return controller
	}
}

class TestStoryboardService: PTStoryboardService {
	var storyboards = [String: PTStoryboardInterface]()
	var storyboard = TestStoryboard()
	func storyboardWith(name: String) -> PTStoryboardInterface {
		if let sb = storyboards[name] {
			return sb
		}
		return storyboard
	}
}
