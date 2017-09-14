//
//  PTNumberRangeQuestionType.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/14/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit
//
//{
//    "question": "What age should your potential partner be?",
//    "category": "hard_fact",
//    "question_type": {
//        "type": "number_range",
//        "range": {
//            "from": 18,
//            "to": 140
//        }
//    }

class PTNumberRangeQuestionType: PTSingleChoiceQuestionType {

	// MARK: Vars
	
	let range: Range<Int>
	
	
    // MARK: Initializer
    
    override init(with json: [String: Any]) {
		let questionTypeDict: [String: Any] = json.any("question_type")
		let range: [String: Int] = questionTypeDict.any("range")
		let from = range["from"] ?? 0
		let to = range["to"] ?? 1
		self.range = from..<(to+1)
        super.init(with: json)
        self.type = .numberRange(self.range)
		
    }
    
    
    // MARK: Actions
    
    override func validate(value: Int) -> PRQuestionTypeEvents {
		if range.contains(value) {
			question.answered = PTQuestionAnswer(with: value)
            return .none
		} else {
			return .reload
		}
    }
}
