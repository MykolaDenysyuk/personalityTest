//
//  PTQuestionViewCell.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/13/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit


class PTQuestionViewCell: PTCollectionViewCell {
    @IBOutlet fileprivate var titleLabel: UILabel!
	
	override func layoutSubviews() {
		super.layoutSubviews()
		let desiredHeight = titleLabel.frame.maxY + titleLabel.frame.origin.y
//		if desiredHeight != contentView.bounds.height {
//			delegate?.cell(self,
//			               requireNewHeight: desiredHeight)
//		}
	}
	
    func setup(with title: String) {
        titleLabel.text = title
    }
}
