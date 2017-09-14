//
//  PTGetQuestionsResponse.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/14/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import Foundation


struct PTGetQuestionsResponse {
    
    let categories: [PTQuestionCategories]
    let questions: [PRQuestionTypeInterface]
    
    init(json: [String: Any], and factory: PTQuestionTypeFactoryInterface) {
        
        let categoriesJson: [String] = json.any("categories")
        self.categories = categoriesJson.flatMap{ PTQuestionCategories(rawValue: $0) }
        
        let questionsJson: [Any] = json.any("questions")
        self.questions = questionsJson.flatMap { factory.questionType(for: $0) }
    }
    
}


extension PTQuestion {
    init(with json: [String: Any]) {
        let categoryString: String = json.any("category")
        self.category = PTQuestionCategories(rawValue: categoryString) ?? .unknown
        let questionString: String = json.any("question")
        self.title = questionString
        self.answered = nil
    }
}

extension PTQuestionAnswer {
    init(with string: String) {
        title = string
        value = nil
    }
    
    init(with int: Int) {
        value = int
        title = ""
    }
}
