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
    
    func setup(with title: String) {
        titleLabel.text = title
    }
}
