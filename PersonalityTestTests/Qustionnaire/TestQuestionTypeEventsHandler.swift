//
//  TestQuestionTypeEventsHandler.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/14/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import Foundation

class TestQuestionTypeEventsHandler: PRQuestionTypeEvents {
	
	enum IsCalled {
		case not
		case addNew(PRQuestionTypeInterface)
		case remove(PRQuestionTypeInterface)
		case reload
	}
	
	fileprivate(set) var isCalled = IsCalled.not
	
	func addNew(question: PRQuestionTypeInterface) {
		isCalled = .addNew(question)
	}
	func remove(question: PRQuestionTypeInterface) {
		isCalled = .remove(question)
	}
	func reload() {
		isCalled = .reload
	}
	
	func reset() {
		isCalled = .not
	}
}
