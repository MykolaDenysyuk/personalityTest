//
//  PTAnswerOptionsView.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/14/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

class PTAnswerOptionsView: PTAnswersView {

	// MARK: Vars
	
	fileprivate var answerViews = [UILabel]()
	override var intrinsicContentSize: CGSize {
		layoutIfNeeded()
		let height = answerViews.last?.frame.maxY ?? 0
		return CGSize(width: UIViewNoIntrinsicMetric,
		              height: height + margins)
	}
	
	
	// MARK: Actions
	
	override func layoutSubviews() {
		super.layoutSubviews()
		let contentWidth = bounds.width - 2 * margins
		var offset = UIOffset(horizontal: margins, vertical: margins)
		for v in answerViews {
			
			func shiftDown() {
				offset.horizontal = margins
				offset.vertical += v.frame.height + margins
			}
			
			let spaceLeftInRow = contentWidth - offset.horizontal
			v.frame.size.width = contentWidth
			v.sizeToFit()
			if v.frame.size.width > spaceLeftInRow {
				if spaceLeftInRow > contentWidth / 3 {
					v.frame.size.width = spaceLeftInRow
					v.sizeToFit()
				}
				else {
					v.frame.size.width = contentWidth
					v.sizeToFit()
					shiftDown()
				}
			}
			
			v.frame.size.width += margins
			v.frame.origin.x = offset.horizontal
			v.frame.origin.y = offset.vertical
			offset.horizontal = v.frame.maxX + margins
			
			if (v.frame.width + offset.horizontal) > contentWidth {
				shiftDown()
			}
		}
	}
	
	func setup(with answers: [PTQuestionnaireViewItem.Answer]) {
		answerViews.forEach { $0.removeFromSuperview() }
		answerViews.removeAll()
		
		for iteration in answers.enumerated() {
			let label = UILabel()
			label.text = iteration.element.title
			label.numberOfLines = 0
			label.tag = iteration.offset
			label.layer.cornerRadius = 6
			label.textAlignment = .center
			label.sizeToFit()
			label.isUserInteractionEnabled = true
			label.clipsToBounds = true
			let tap = UITapGestureRecognizer(target: self,
			                                 action: #selector(tapAction(_:)))
			label.addGestureRecognizer(tap)
			setAnswer(view: label, selected: iteration.element.isSelected)
			addSubview(label)
			answerViews.append(label)
		}
		setNeedsLayout()
	}
	
	@objc fileprivate func tapAction(_ sender: UIGestureRecognizer) {
		guard let label = sender.view as? UILabel else {return}
		for v in answerViews {
			setAnswer(view: v, selected: label.tag == v.tag)
		}
        delegate?.didSelectAnswer(index: label.tag)
	}
	
	fileprivate func setAnswer(view: UILabel, selected: Bool) {
		let darkColor = UIColor(red: 102/255, green: 102/255, blue: 1, alpha: 1)
		let lightColor = UIColor.white
		if selected {
			view.backgroundColor = darkColor
			view.textColor = lightColor
			view.layer.borderWidth = 0
		}
		else {
			view.backgroundColor = lightColor
			view.textColor = darkColor
			view.layer.borderColor = darkColor.cgColor
			view.layer.borderWidth = 1
		}
	}

}
