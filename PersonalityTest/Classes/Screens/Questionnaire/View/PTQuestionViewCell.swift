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
		let targetSize = titleLabel.systemLayoutSizeFitting(CGSize(width: contentView.bounds.width - 2 * titleLabel.frame.origin.x,
		                                                           height: 0))
		let desiredHeight = ceil(targetSize.height + 2*titleLabel.frame.origin.y)
		let currentHeight = ceil(contentView.bounds.height)
		if desiredHeight != currentHeight {
			delegate?.cell(self,
			               requireNewHeight: desiredHeight)
		}
	}
	
    func setup(with title: String) {
        titleLabel.text = title
    }
}
