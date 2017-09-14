//
//  PTQuestionTypeFactory.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/14/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

class PTQuestionTypeFactory: PTQuestionTypeFactoryInterface {
    
    func questionType(for json: Any) -> PRQuestionTypeInterface? {
        guard let json = json as? [String: Any] else { return nil }
        
        guard
            let questionType = json["question_type"] as? [String: Any],
            let typeString = questionType["type"] as? String,
            let type = PTQuestionTypes(rawValue: typeString)
            else { return nil }
     
        switch type {
            
        case .singleChoice:
            return PTSingleChoiceQuestionType(with: json)
            
        case .singleChoiceConditional:
            return PTSingleChoiceConditionalQuestionType(with: json, and: self)
            
        case .numberRange:
            return PTNumberRangeQuestionType(with: json)
        }
        
    }
    
}
