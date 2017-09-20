//
//  PTQuestionnaireViewLayout.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/14/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

protocol PTLayoutContainerInterface {
    var frame: CGRect { get }
    var traitCollection: UITraitCollection { get }
}

extension UIView: PTLayoutContainerInterface {}

class PTQuestionnaireViewLayout {

    // MARK: Vars
    
    fileprivate var sections = [Int: Section]()
	fileprivate var container: PTLayoutContainerInterface
	
    
    // MARK: Initializer
    
	init(container: PTLayoutContainerInterface) {
		self.container = container
	}
	
    
    // MARK: Actions
    
	func invalidate() {
		sections.removeAll()
	}
	/** returns true if height has actually been updated */
	@discardableResult
	func update(height: CGFloat, forItemAt index: IndexPath) -> Bool {
        let row = self.row(at: index)
        
        if index.item % 2 > 0 {
            row.rightSide = height
			return row.rightSide == height
        } else {
            row.leftSide = height
			return row.leftSide == height
        }        
	}
	
	func sizeForItem(at index: IndexPath) -> CGSize {
		let row = self.row(at: index)
		let contentWidth = container.frame.width
        let itemHeight = index.item % 2 > 0 ? row.rightSide : row.leftSide
		if container.traitCollection.horizontalSizeClass == .regular {
			return CGSize(width: contentWidth/2,
			              height: itemHeight)
		}
		else {
			return CGSize(width: contentWidth,
			              height: itemHeight)
		}
	}
    
    fileprivate func row(at index: IndexPath) -> CompactRow {
        func newRow() -> CompactRow {
            return container.traitCollection.horizontalSizeClass == .regular ? RegularRow() : CompactRow()
        }
        
        let section = sections[index.section] ?? Section()
        let _index = index.item / 2
        let row = section.rows[_index] ?? newRow()
        section.rows[_index] = row
        sections[index.section] = section
        return row
    }
}

extension PTQuestionnaireViewLayout {
    class CompactRow {
		static let defaultQuestionHeigth: CGFloat = 30
		static let defualtAnswerHeight: CGFloat = 44
        var leftSide = CompactRow.defaultQuestionHeigth
        var rightSide = CompactRow.defualtAnswerHeight
    }
    
    class RegularRow: CompactRow {
        override var leftSide: CGFloat {
            set {
                super.leftSide = max(newValue, rightSide)
                super.rightSide = self.leftSide
            }
            get {return super.leftSide}
        }
        override var rightSide: CGFloat {
            set {
                super.rightSide = max(newValue, leftSide)
                super.leftSide = self.rightSide 
            }
            get {return super.rightSide}
        }
    }
    
    class Section {
        var rows = [Int: CompactRow]()
    }
}
