//
//  PTQuestionnaireCoordinatorTests.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/15/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import XCTest

class PTQuestionnaireCoordinatorTests: XCTestCase {
	
	var coordinator: PTQuestionnaireCoordinator!
	var storyboard: TestStoryboardService!
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
		coordinator = PTQuestionnaireCoordinator()
		storyboard = TestStoryboardService()
		storyboard.storyboard.controller = PTQuestionnaireViewController()
		PTServices.setService(storyboard)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: -
	
	func test_startFromWindow() {
		let window = TestWindow()
		let stub = storyboard.storyboard.controller
		
		coordinator.start(from: window)
		
		let exp1 = expectation(description: #function)
		let exp2 = expectation(description: #function)
		
		for call in window.allCalls {
			switch call {
			case .didSetRootController(let vc):
				XCTAssertEqual(vc, stub,
				"coordinator presents wrong controller")
				exp1.fulfill()
			case .makeKeyAndVisible:
				exp2.fulfill()
				break
			default: break
			}
		}
		
		waitForExpectations(timeout: 0,
		                    handler: waitForExpactations)
	}
	
	func test_startFromController() {
		let controller = TestViewController()
		let stub = storyboard.storyboard.controller
		
		coordinator.start(from: controller)
		
		let exp = expectation(description: #function)
		
		switch controller.isCalled {
		case .show(let vc, _):
			XCTAssertEqual(vc, stub,
			"coordinator presents wrong controller")
			exp.fulfill()
		default:
			break
		}
		
		waitForExpectations(timeout: 0,
		                    handler: waitForExpactations)
	}
	
	func test_showResults() {
		let stub = PTQuestionnaireResultsViewController()
		storyboard.storyboard.controller = stub
		let results: [PTQuestionnaireResult] = [("test", [("que", "ans")])]
		let sender = UIView()
		let mock = TestViewController()
		
		coordinator.showResults(results,
		                        from: mock,
		                        sender: sender)
		
		let exp = expectation(description: #function)
		
		switch mock.isCalled {
		case .present(let container):
			XCTAssert(container.childViewControllers.contains(stub),
			"coordinator presents wrong controller")
			exp.fulfill()
		default:
			break
		}
		
		waitForExpectations(timeout: 0,
		                    handler: waitForExpactations)
	}
	
	func test_closeResults() {
		let mock = TestViewController()
		
		coordinator.closeResults(sender: mock)
		
		let exp = expectation(description: #function)
		
		switch mock.isCalled {
		case .dismiss:
			exp.fulfill()
		default:
			break
		}
		
		waitForExpectations(timeout: 0,
		                    handler: waitForExpactations)
	}
}
