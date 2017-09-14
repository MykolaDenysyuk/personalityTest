//
//  PTNumberRangeQuestionTypeTests.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/14/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import XCTest

class PTNumberRangeQuestionTypeTests: XCTestCase {
	
	var type: PTNumberRangeQuestionType!
	let json = QuestionTypeJSONs.numberRange
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
		
		type = PTNumberRangeQuestionType(with: json)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: -
	
	func test_validate() {
		let answer = PTQuestionAnswer(with: 15)
		type.validate(answer: answer)
		
		XCTAssertNotNil(type.question.answered,
		                "this answer is valid")
	}
	
	func test_validate_fail() {
		let answer = PTQuestionAnswer(with: 61)
		let eventHandler = TestQuestionTypeEventsHandler()
		
		type.eventsHandler = eventHandler
		type.validate(answer: answer)
		
		XCTAssertNil(type.question.answered,
		             "this answer is invalid")
		
		let exp = expectation(description: #function)
		
		switch eventHandler.isCalled {
		case .reload:
			exp.fulfill()
		default:
			break
		}
		
		waitForExpectations(timeout: 0,
		                    handler: waitForExpactations)
	}
	
}
