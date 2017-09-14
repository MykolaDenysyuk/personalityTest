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
    case unknown
    case singleChoice = "single_choice"
    case singleChoiceConditional = "single_choice_conditional"
    case numberRange = "number_range"
}

protocol PRQuestionTypeInterface {
    var type: PTQuestionTypes {get}
    var answers: [PTQuestionAnswer] {get}
    func validate(answer: PTQuestionAnswer) -> Bool
}

struct PTQuestionAnswer {
    let title: String
    let value: Int?
}

struct PTQuestion {
    let title: String
    let category: PTQuestionCategories
    let type: PTQuestionTypes
    let answered: PTQuestionAnswer?
}



