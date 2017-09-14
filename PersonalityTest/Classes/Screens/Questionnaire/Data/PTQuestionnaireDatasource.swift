//
//  PTQuestionnaireDatasource.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/14/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

/** Acts as datasource and events handler for PTQuestionnaireViewController */
class PTQuestionnaireDatasource: NSObject {

	// MARK: Definitions
	
	struct Category {
		let title: String
		let items: [PTQuestionnaireViewItem]
	}
	
	
	// MARK: Vars
	
	var categories = [Category]()
	var questionTypesFactory: PTQuestionTypeFactoryInterface
		= PTQuestionTypeFactory()
	
	// MARK: Actions
	
	func loadQuestions(_ complete: @escaping () -> ()) {
		PTServices.network.get(path: "quesitions") { [weak self]
			(networkResponse) in
			if let sself = self {
				switch networkResponse {
				case .failure(let err):
					print("Oops! \(err.localizedDescription)")
				
				case .success(let json):
					let response = PTGetQuestionsResponse(json: json,
					                                      and: sself.questionTypesFactory)
					sself.wrapIntoCategories(response)
				}
				
			}
			complete()
		}
	}

	func wrapIntoCategories(_ response: PTGetQuestionsResponse) {
		
		var questionsPerCategory = [PTQuestionCategories: [PTQuestionnaireViewItem]]()
		
		func appendIntoApproptiateCategory(_ q: PRQuestionTypeInterface) {
			let key = q.question.category
			var list = questionsPerCategory[key] ?? []
			
			list.append(PTQuestionnaireViewItem.questionItem(q))
			list.append(PTQuestionnaireViewItem.answerItem(q))
			
			questionsPerCategory[key] = list
		}
		
		for q in response.questions {
			appendIntoApproptiateCategory(q)
		}
		
		var newCategories = [Category]()
		
		for key in response.categories {
			if let list = questionsPerCategory[key] {
				let category = Category(title: key.rawValue,
				                        items: list)
				newCategories.append(category)
				questionsPerCategory[key] = nil
			}
		}
		
		self.categories = newCategories
	}
}

extension PTQuestionnaireDatasource: PTQuestionnaireViewDatasourceInterface {
	func numberOfCategories() -> Int {
		return categories.count
	}
	
	func title(for category: Int) -> String {
		return categories[category].title
	}
	
	func numberOfQuestions(in category: Int) -> Int {
		return categories[category].items.count
	}
	
	func question(at index: IndexPath) -> PTQuestionnaireViewItem {
		return categories[index.section].items[index.row]
	}
}

extension PTQuestionnaireDatasource: PTQuestionnaireViewOutput {
	func viewRequiresData(_ view: PTQuestionnaireViewIntput) {
		self.loadQuestions {
			view.reload()
		}
	}
	
	func view(_ view: PTQuestionnaireViewIntput, didSelectAnswer: Int, forQuestionAt index: IndexPath) {
		// todo
	}
}

extension PTQuestionnaireViewItem {
	
	static func questionItem(_ question: PRQuestionTypeInterface) -> PTQuestionnaireViewItem {
		return PTQuestionnaireViewItem(type: .question(question.question.title))
	}
	
	static func answerItem(_ question: PRQuestionTypeInterface) -> PTQuestionnaireViewItem {
		
		switch question.type {
		case .numberRange(let range):
			return PTQuestionnaireViewItem(type: .answers(.numberRange(range: range,
			                                                           current: nil)))
		
		case .singleChoiceConditional(let answers), .singleChoice(let answers):
			let _answers = answers.map {Answer(title: $0.title, isSelected: false)}
			return PTQuestionnaireViewItem(type: .answers(.singleChoice(answers: _answers)))		
		}
	}
	
}
