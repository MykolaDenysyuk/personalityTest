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

    
    // MARK: Initializer
    
    override init(with json: [String: Any]) {
        super.init(with: json)
        self.type = .numberRange
        let questionTypeDict: [String: Any] = json.any("question_type")
        let range: [String: Int] = questionTypeDict.any("range")
        let from = range["from"] ?? 0
        let to = range["to"] ?? 1
        self.answers = [
            PTQuestionAnswer(with: from),
            PTQuestionAnswer(with: to)
        ]
    }
    
    
    // MARK: Actions
    
    override func validate(answer: PTQuestionAnswer) {
        
    }
}
