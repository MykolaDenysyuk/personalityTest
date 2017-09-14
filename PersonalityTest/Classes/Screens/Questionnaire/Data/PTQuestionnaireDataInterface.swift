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

enum PTQuestionTypes {
    case singleChoice([PTQuestionAnswer])
    case singleChoiceConditional([PTQuestionAnswer])
    case numberRange(Range<Int>)
}

enum PRQuestionTypeEvents {
    case none
    case addNew(PRQuestionTypeInterface)
    case remove(PRQuestionTypeInterface)
    case reload
}

protocol PRQuestionTypeInterface {
    var question: PTQuestion {get}
    var type: PTQuestionTypes {get}
    
    func validate(value: Int) -> PRQuestionTypeEvents
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
