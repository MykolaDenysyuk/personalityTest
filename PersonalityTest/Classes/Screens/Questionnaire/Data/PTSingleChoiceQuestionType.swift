//
//  PTSingleChoiceQuestionType.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/14/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit
//
//"question": "What is your gender?",
//"category": "hard_fact",
//"question_type": {
//    "type": "single_choice",
//    "options": [
//    "male",
//    "female",
//    "other"
//    ]
//}
//},

class PTSingleChoiceQuestionType: PRQuestionTypeInterface {

    // MARK: Vars
    
    var question: PTQuestion
    var type: PTQuestionTypes
    var answers: [PTQuestionAnswer]
    var eventsHandler: PRQuestionTypeEvents!
    
    // MARK: Initializer
    
    init(with json: [String: Any]) {
        question = PTQuestion(with: json)
        let questionTypeDict: [String: Any] = json.any("question_type")
        let options: [String] = questionTypeDict.any("options")
        self.answers = options.map{ PTQuestionAnswer(with: $0) }
		self.type = .singleChoice(self.answers)
    }
    
    
    // MARK: Actions
    
    func validate(answer: PTQuestionAnswer) {
        question.answered = answer
    }
    
}
