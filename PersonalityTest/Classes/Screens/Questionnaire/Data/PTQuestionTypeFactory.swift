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
            let typeString = questionType["type"] as? String
            else { return nil }
     
        switch typeString {
            
        case "single_choice":
            return PTSingleChoiceQuestionType(with: json)
            
        case "single_choice_conditional":
            return PTSingleChoiceConditionalQuestionType(with: json, and: self)
            
        case "number_range":
            return PTNumberRangeQuestionType(with: json)
			
		default:
			return nil
        }
        
    }
    
}
