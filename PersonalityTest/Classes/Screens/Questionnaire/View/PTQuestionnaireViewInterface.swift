//
//  PTQuestionnaireViewInterface.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/12/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import Foundation

struct PTQuestionnaireViewItem {
    
    enum Types {
        case question(String)
        case answers(AnswersViewTypes)
    }
    
    enum AnswersViewTypes {
        case singleChoice(answers: [Answer])
        case numberRange(range: Range<Int>, current: Int)
    }

    struct Answer {
        let title: String
        let isSelected: Bool
    }
    
    let type: Types
}


struct PTAnswer {
    let title: String
    let isSelected: Bool
}


protocol PTQuestionnaireViewIntput {
    func reload()
    func reloadQuestions(at indexes: [IndexPath])
    func reloadCategory(at index: Int)
    func insertNewQuestions(at indexes: [IndexPath])
    func removeQuestions(at indexes: [IndexPath])
}

protocol PTQuestionnaireViewOutput: class {
    func viewRequiresData(_ view: PTQuestionnaireViewIntput)
    func view(_ view: PTQuestionnaireViewIntput,
              didSelectAnswer: Int,
              forQuestionAt index: IndexPath)
}

protocol PTQuestionnaireViewDatasourceInterface {
    func numberOfCategories() -> Int
    func titleFor(gategory: Int) -> String
    func numberOfQuestions(in gategory: Int) -> Int
    func question(at index: IndexPath) -> PTQuestionnaireViewItem
}
