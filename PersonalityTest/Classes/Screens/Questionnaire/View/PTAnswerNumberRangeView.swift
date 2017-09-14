//
//  PTAnswerNumberRangeView.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/14/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

class PTAnswerNumberRangeView: PTAnswersView {
	
	// MARK: Vars
	
	@IBOutlet fileprivate var slider: UISlider!
	@IBOutlet fileprivate var titleLabel: UILabel!
	override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
		return CGSize(width: UIViewNoIntrinsicMetric,
		              height: titleLabel.frame.height + slider.frame.height + 3 * margins)
	}
	
	
	static func loadView() -> PTAnswerNumberRangeView {
		let nib = UINib(nibName: "PTAnswerNumberRangeView",
		                bundle: nil)
		if let view = nib.instantiate(withOwner: nil,
		                              options: nil).first as? PTAnswerNumberRangeView {
			return view
		}
		fatalError()
	}
	
	
	// MARK: Actions
	
	override func layoutSubviews() {
		super.layoutSubviews()
		slider.frame.size.width = bounds.width - 2 * margins
		slider.center.x = bounds.midX
		slider.center.y = bounds.midY
	}
	
	@IBAction fileprivate func sliderAction() {
		let value = Int(slider.value)
		delegate?.didSelectAnswer(index: value)
		reloadTitle(value: value)
	}
	
	func setup(with range: Range<Int>, current: Int?) {
		slider.minimumValue = Float(range.lowerBound)
		slider.maximumValue = Float(range.upperBound)
		let value = current ?? (range.upperBound - range.lowerBound)/2
		slider.value = Float(value)
		reloadTitle(value: value)
	}
	
	fileprivate func reloadTitle(value: Int) {
		
		titleLabel.text = "\(value) year\(value == 1 ? "" : "s")"
	}
}
