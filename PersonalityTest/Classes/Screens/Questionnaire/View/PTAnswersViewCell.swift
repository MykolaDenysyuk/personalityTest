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

class PTAnswersViewCell: PTCollectionViewCell {
    
    weak var answerDelegate: PTAnswersViewCellDelegate?
    
    func setup(with type: PTQuestionnaireViewItem.AnswersViewTypes) {
        // todo: add answers view depending on answers type
    }
    
}
