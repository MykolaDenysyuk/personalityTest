//
//  PTAnswersViewCell.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/13/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

protocol PTAnswersViewCellDelegate: class {
    // where answere both value or answer index depending on answers type
    func answersCell(_ cell: PTAnswersViewCell, didSelectAnswer answer: Int)
}

class PTAnswersViewCell: PTCollectionViewCell, PTAnswersViewDelegate {
	
	// MARK: Vars
	
    weak var answerDelegate: PTAnswersViewCellDelegate?
	fileprivate var container: PTAnswersView? {
		didSet {
			if let newValue = container {
				newValue.delegate = self
				contentView.addSubview(newValue)
			}
			oldValue?.delegate = nil
			oldValue?.removeFromSuperview()
		}
	}
	
	// MARK: Actions
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		if let view = self.container {
			view.frame = bounds
			let desiredHeight = ceil(view.intrinsicContentSize.height)
			if desiredHeight != ceil(bounds.size.height) {
				delegate?.cell(self,
				               requireNewHeight: desiredHeight)
			}
		}
	}
	
    func setup(with type: PTQuestionnaireViewItem.AnswersViewTypes) {
		container = nil
		
		switch type {
		case .numberRange(let range, let current):
			let rangeView = PTAnswerNumberRangeView.loadView()
			rangeView.setup(with: range, current: current)
			container = rangeView
		
		case .singleChoice(let answers):
			let optionsView = PTAnswerOptionsView()
			optionsView.setup(with: answers)
			container = optionsView
		}
    }
	
	func didSelectAnswer(index: Int) {
		answerDelegate?.answersCell(self,
		                            didSelectAnswer: index)
	}
    
}


protocol PTAnswersViewDelegate: class {
	func didSelectAnswer(index: Int)
}

class PTAnswersView: UIView {
	let margins: CGFloat = 8
	weak var delegate: PTAnswersViewDelegate?
	
}
