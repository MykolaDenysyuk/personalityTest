//
//  TestWindow.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/15/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

class TestWindow: UIWindow {

	enum IsCalled {
		case not
		case didSetRootController(UIViewController?)
		case makeKeyAndVisible
	}

	
	fileprivate(set) var isCalled = IsCalled.not {
		didSet {
			allCalls.append(isCalled)
		}
	}
	fileprivate(set) var allCalls = [IsCalled]()
	
	override var rootViewController: UIViewController? {
		didSet {
			super.rootViewController = rootViewController
			isCalled = .didSetRootController(rootViewController)
		}
	}
	
	override func makeKeyAndVisible() {
//		super.makeKeyAndVisible()
		isCalled = .makeKeyAndVisible
	}
}
