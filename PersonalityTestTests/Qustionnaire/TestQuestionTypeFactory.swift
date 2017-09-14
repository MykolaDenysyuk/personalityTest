//
//  TestQuestionTypeFactory.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/14/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import Foundation

class TestQuestionTypeFactory: PTQuestionTypeFactoryInterface {
	
	var type: PRQuestionTypeInterface?
	
	func questionType(for json: Any) -> PRQuestionTypeInterface? {
		return type
	}
	
}
