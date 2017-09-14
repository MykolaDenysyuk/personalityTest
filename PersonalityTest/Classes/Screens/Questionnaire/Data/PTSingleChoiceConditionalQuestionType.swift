//
//  PTSingleChoiceConditionalQuestionType.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/14/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

//{
//    "question": "How important is the age of your partner to you?",
//    "category": "hard_fact",
//    "question_type": {
//        "type": "single_choice_conditional",
//        "options": [
//        "not important",
//        "important",
//        "very important"
//        ],
//        "condition": {
//            "predicate": {
//                "exactEquals": [
//                "${selection}",
//                "very important"
//                ]
//            },
//            "if_positive": {
//                "question": "What age should your potential partner be?",
//                "category": "hard_fact",
//                "question_type": {
//                    "type": "number_range",
//                    "range": {
//                        "from": 18,
//                        "to": 140
//                    }
//                }
//            }
//        }
//    }
//},

class PTSingleChoiceConditionalQuestionType: PTSingleChoiceQuestionType {

    // MARK: Vars
    
    let relatedQuestion: PRQuestionTypeInterface
    
    // MARK: Initializer
    
    init?(with json: [String: Any], and factory: PTQuestionTypeFactoryInterface) {
        let questionTypeDict: [String: Any] = json.any("question_type")
        let condition: [String: Any] = questionTypeDict.any("condition") // todo
        if let ifPositive = questionTypeDict["if_positive"],
            let relatedQuestion = factory.questionType(for: ifPositive) {
            self.relatedQuestion = relatedQuestion
        }
        else {
            print("can't parse the question: \(json)")
            return nil
        }
        
        super.init(with: json)
        type = .singleChoiceConditional
    }
    
    
    // MARK: Actions
    
    override func validate(answer: PTQuestionAnswer) {
        
    }
    
}
