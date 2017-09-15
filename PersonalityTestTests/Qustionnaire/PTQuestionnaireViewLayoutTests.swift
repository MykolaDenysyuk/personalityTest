//
//  PTQuestionnaireViewLayoutTests.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/15/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import XCTest

class PTQuestionnaireViewLayoutTests: XCTestCase {
    
    var layout: PTQuestionnaireViewLayout!
    var container: TestLayoutContainer!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        container = TestLayoutContainer(with: CGRect(x: 0, y: 0, width: 200, height: 200),
                                        and: UITraitCollection())
        layout = PTQuestionnaireViewLayout(container: container)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // MARK: -
    
    func test_updateSize_regular() {
        container.traitCollection = UITraitCollection(horizontalSizeClass: .regular)
        let expectedHeight: CGFloat = 189
        let lowerHeight = expectedHeight/2
        let qIndex = IndexPath(item: 10, section: 18)
        let aIndex = IndexPath(item: 11, section: 18)
        
        layout.update(height: expectedHeight,
                      forItemAt: qIndex)
        layout.update(height: lowerHeight,
                      forItemAt: aIndex)
        
        let questionRowHeiht = layout.sizeForItem(at: qIndex).height
        let answerRowHeight = layout.sizeForItem(at: aIndex).height
        
        XCTAssertEqual(questionRowHeiht, answerRowHeight,
                       "both answer and question rows should be same height when view's horizontal size class is regular")
    }
    
    func test_updateSize_compact() {
        container.traitCollection = UITraitCollection(horizontalSizeClass: .compact)
        let qExpectedHeight: CGFloat = 189
        let aExpectedHeight = qExpectedHeight/2
        let qIndex = IndexPath(item: 10, section: 18)
        let aIndex = IndexPath(item: 11, section: 18)
        
        layout.update(height: qExpectedHeight,
                      forItemAt: qIndex)
        layout.update(height: aExpectedHeight,
                      forItemAt: aIndex)
        
        let questionRowHeiht = layout.sizeForItem(at: qIndex).height
        let answerRowHeight = layout.sizeForItem(at: aIndex).height
        
        XCTAssertEqual(questionRowHeiht, qExpectedHeight,
                       "question row should have its own height when view's horizontal size class is compact")
        XCTAssertEqual(answerRowHeight, aExpectedHeight,
                       "question row should have its own height when view's horizontal size class is compact")
    }
    
    func test_invalidate_regular() {
        container.traitCollection = UITraitCollection(horizontalSizeClass: .regular)
        let index = IndexPath(item: 10, section: 18)
        let defaultHeight = layout.sizeForItem(at: index).height
        let notExpectedHeight = defaultHeight * 4.2
        
        layout.update(height: notExpectedHeight,
                      forItemAt: index)
        layout.invalidate()
        
        let result = layout.sizeForItem(at: index).height
        
        let msg = "item height should be reset back to default when layot is invalidated"
        XCTAssertNotEqual(result, notExpectedHeight, msg)
        XCTAssertEqual(result, defaultHeight, msg)
    }

    func test_invalidate_compact() {
        container.traitCollection = UITraitCollection(horizontalSizeClass: .compact)
        let index = IndexPath(item: 10, section: 18)
        let defaultHeight = layout.sizeForItem(at: index).height
        let notExpectedHeight = defaultHeight * 4.2
        
        layout.update(height: notExpectedHeight,
                      forItemAt: index)
        layout.invalidate()
        
        let result = layout.sizeForItem(at: index).height
        
        let msg = "item height should be reset back to default when layot is invalidated"
        XCTAssertNotEqual(result, notExpectedHeight, msg)
        XCTAssertEqual(result, defaultHeight, msg)
    }
    
}
