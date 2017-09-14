//
//  Helpers.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/14/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import XCTest

struct QuestionTypeJSONs {
	static let numberRange: [String: Any] = [
		"question": "do you use unit tests?",
		"category": "hard_fact",
		"question_type": [
			"type": "number_range",
			"from": 20,
			"to": 40
		]
	]
	static let conditionChoice: [String: Any] = [
		"question": "do you use unit tests?",
		"category": "hard_fact",
		"question_type": [
			"type": "single_choice_conditional",
			"options": [
				"not important",
				"important",
				"very important"
			],
			"condition": [
				"predicate": [
					"exactEquals": [
						"${selection}",
						"this one should pass"
					]
				],
				"if_positive": QuestionTypeJSONs.numberRange
			]
		]
	]
}

func waitForExpactations(error: Error?) {
	if let error = error {
		XCTFail(error.localizedDescription)
	}
}

