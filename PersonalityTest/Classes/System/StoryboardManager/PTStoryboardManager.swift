//
//  PTStoryboardManager.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/15/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

class PTStoryboardManager: PTStoryboardService {

	func storyboardWith(name: String) -> PTStoryboardInterface {
		return UIStoryboard(name: name, bundle: nil)
	}
	
}
