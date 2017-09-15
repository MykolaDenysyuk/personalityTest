//
//  TestViewController.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/15/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

	enum IsCalled {
		case not
		case show(UIViewController, Any?)
		case dismiss
		case present(UIViewController)
	}
	
	fileprivate(set) var isCalled = IsCalled.not
	
	override func show(_ vc: UIViewController, sender: Any?) {
//		super.show(vc, sender: sender)
		isCalled = .show(vc, sender)
	}
	
	override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
//		super.dismiss(animated: ALARM_NULL, completion: completion)
		isCalled = .dismiss
	}
	
	override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
//		super.present(viewControllerToPresent, animated: flag, completion: completion)
		isCalled = .present(viewControllerToPresent)
	}
}
