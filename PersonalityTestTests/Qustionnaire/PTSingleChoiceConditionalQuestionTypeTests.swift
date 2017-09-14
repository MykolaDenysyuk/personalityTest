//
//  PTSingleChoiceConditionalQuestionTypeTests.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/14/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import XCTest

class PTSingleChoiceConditionalQuestionTypeTests: XCTestCase {
	
	var type: PTSingleChoiceConditionalQuestionType!
	let json = QuestionTypeJSONs.conditionChoice
	var factory: TestQuestionTypeFactory!
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
		factory = TestQuestionTypeFactory()
		factory.type = PTNumberRangeQuestionType(with: QuestionTypeJSONs.numberRange)
		type = PTSingleChoiceConditionalQuestionType(with: json,
		                                             and: factory)!
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
	
	// MARK: -
	
	func test_validate() {
		
		let _ = type.validate(value: 1)
		
		XCTAssertNotNil(type.question.answered,
		                "the question should be answered at this point since the answer is valid")
	}
	
	func test_addNewQuestion() {
		
		let result = type.validate(value: 1)
		
		let exp = expectation(description: #function)
		switch result {
		case .addNew(let newQuestionType):
			XCTAssertEqual(newQuestionType.question.title,
			               type.relatedQuestion.question.title,
			               "wrong question is added")
			exp.fulfill()
		default:
			break
		}
		
		waitForExpectations(timeout: 0,
		                    handler: waitForExpactations)
	}
	
	func test_addNewQuestionTwice() {
		
		let _ = type.validate(value: 1)
		
		let result = type.validate(value: 1)
		
		let exp = expectation(description: #function)
		switch result {
		case .none:
			exp.fulfill()
		default:
			XCTFail("same answer should not be applied more then once")
		}
		
		waitForExpectations(timeout: 0,
		                    handler: waitForExpactations)
	}
	
	func test_removeQuestion() {
		
		let _ = type.validate(value: 1)
				
		let result = type.validate(value: 0)
		
		let exp = expectation(description: #function)
		switch result {
		case .remove(let questionType):
			XCTAssertEqual(questionType.question.title,
			               type.relatedQuestion.question.title,
			               "wrong question is removed")
			exp.fulfill()
		default:
			break
		}
		
		waitForExpectations(timeout: 0,
		                    handler: waitForExpactations)
	}
	
	func test_removeQuestion_twice() {
		
		let _ = type.validate(value: 1)
		let _ = type.validate(value: 0)
		
		let result = type.validate(value: 0)
		
		let exp = expectation(description: #function)
		switch result {
		case .none:
			
			exp.fulfill()
		default:
			XCTFail("the question that is removed shouldn't be removed again")
			break
		}
		
		waitForExpectations(timeout: 0,
		                    handler: waitForExpactations)
	}
	
}
