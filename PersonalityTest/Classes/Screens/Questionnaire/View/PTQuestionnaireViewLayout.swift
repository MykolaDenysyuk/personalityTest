//
//  PTQuestionnaireViewLayout.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/14/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

class PTQuestionnaireViewLayout {

	fileprivate var itemsHeight = [Int: CGFloat]()
	fileprivate var container: UIView
	
	init(container: UIView) {
		self.container = container
	}
	
	func invalidate() {
		itemsHeight.removeAll()
	}
	
	func update(height: CGFloat, forItemAt index: Int) {
		if container.traitCollection.horizontalSizeClass == .regular {
			let partnerIndex = index % 2 > 0 ? index - 1 : index + 1
			let partnerHeight = itemsHeight[partnerIndex] ?? height
			let maxHeight = max(partnerHeight, height)
			itemsHeight[index] = maxHeight
			itemsHeight[partnerIndex] = maxHeight
		}
		else {
			itemsHeight[index] = height
		}
	}
	
	func sizeForItem(at index: Int) -> CGSize {
		let itemHeight = itemsHeight[index] ?? 60 // let it be ~60
		let contentWidth = container.frame.width
		if container.traitCollection.horizontalSizeClass == .regular {
			return CGSize(width: contentWidth/2,
			              height: itemHeight)
		}
		else {
			return CGSize(width: contentWidth,
			              height: itemHeight)
		}
	}
}
