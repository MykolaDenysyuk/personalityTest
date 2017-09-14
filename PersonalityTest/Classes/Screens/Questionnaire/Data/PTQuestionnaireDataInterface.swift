//
//  PTQuestionnaireDataInterface.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/12/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import Foundation


enum PTQuestionCategories: String {
    case unknown
    case hardFact = "hard_fact"
    case lifestyle = "lifestyle"
    case introversion = "introversion"
    case passion = "passion"
}

enum PTQuestionTypes: String {
    case singleChoice = "single_choice"
    case singleChoiceConditional = "single_choice_conditional"
    case numberRange = "number_range"
}

protocol PRQuestionTypeEvents: class {
    func addNew(question: PRQuestionTypeInterface)
    func remove(question: PRQuestionTypeInterface)
    func reload()
}

protocol PRQuestionTypeInterface {
    var question: PTQuestion {get}
    var type: PTQuestionTypes {get}
    var answers: [PTQuestionAnswer] {get}
    var eventsHandler: PRQuestionTypeEvents! {get set}
    
    func validate(answer: PTQuestionAnswer)
}

struct PTQuestionAnswer {
    let title: String
    let value: Int?
}

struct PTQuestion {
    let title: String
    let category: PTQuestionCategories
    var answered: PTQuestionAnswer?
}

protocol PTQuestionTypeFactoryInterface {
    func questionType(for json: Any) -> PRQuestionTypeInterface?
}
