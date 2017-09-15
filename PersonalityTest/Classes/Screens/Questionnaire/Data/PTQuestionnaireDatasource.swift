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
		var items: [ItemWrapper]
	}
    
    struct ItemWrapper {
        var viewItem: PTQuestionnaireViewItem
        let dataItem: PRQuestionTypeInterface
    }
	
	
	// MARK: Vars
	
	var categories = [Category]()
	var questionTypesFactory: PTQuestionTypeFactoryInterface
		= PTQuestionTypeFactory()
	var answeredQuestionsCount = 0
    
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
		
		var questionsPerCategory = [PTQuestionCategories: [ItemWrapper]]()
		
		func appendIntoApproptiateCategory(_ q: PRQuestionTypeInterface) {
			let key = q.question.category
			var list = questionsPerCategory[key] ?? []
			
			list.append(ItemWrapper(viewItem: PTQuestionnaireViewItem.questionItem(q),
			                        dataItem: q))
			list.append(ItemWrapper(viewItem: PTQuestionnaireViewItem.answerItem(q),
			                        dataItem: q))
            if q.question.answered != nil {
                answeredQuestionsCount += 1
            }
			
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
		return categories[index.section].items[index.row].viewItem
	}
    
    func result() -> [PTQuestionnaireResult] {
        if answeredQuestionsCount > 0 {
            var all = [PTQuestionnaireResult]()
            for c in categories {
                var answers = [(String, String)]()
                for q in c.items {
                    if let answer = q.dataItem.question.answered {
                        answers.append((q.dataItem.question.title,
                                        answer.title))
                    }
                }
                if answers.count > 0 {
                    all.append((c.title, answers))
                }
            }
            return all
        }
        else {
            return []
        }
    }
}

extension PTQuestionnaireDatasource: PTQuestionnaireViewOutput {
	func viewRequiresData(_ view: PTQuestionnaireViewIntput) {
		self.loadQuestions {
			view.reload()
		}
	}
	
	func view(_ view: PTQuestionnaireViewIntput, didSelectAnswer: Int, forQuestionAt index: IndexPath) {
        var category = categories[index.section]
		var item = category.items[index.item]
        let oldQuestionValue = item.dataItem
        let result = item.dataItem.validate(value: didSelectAnswer)
        item.viewItem = PTQuestionnaireViewItem.answerItem(item.dataItem)
        category.items[index.item] = item
        categories[index.section] = category
        
        switch result {
        case .addNew(let q):
            answeredQuestionsCount += 1
            category.items.insert(ItemWrapper(viewItem: PTQuestionnaireViewItem.questionItem(q),
                                              dataItem: q),
                                  at: index.item + 1)
            category.items.insert(ItemWrapper(viewItem: PTQuestionnaireViewItem.answerItem(q),
                                              dataItem: q),
                                  at: index.item + 2)
            categories[index.section] = category
            view.insertNewQuestions(at: [IndexPath(item: index.item+1, section: index.section),
                                         IndexPath(item: index.item+2, section: index.section)])
        case .remove(_):
            answeredQuestionsCount += 1
            category.items.remove(at: index.item+2)
            category.items.remove(at: index.item+1)
            categories[index.section] = category
            view.removeQuestions(at: [IndexPath(item: index.item+1, section: index.section),
                                      IndexPath(item: index.item+2, section: index.section)])
        case .reload:
            answeredQuestionsCount += 1
            item.viewItem = PTQuestionnaireViewItem.answerItem(oldQuestionValue)
            category.items[index.section] = item
            categories[index.section] = category
            view.reloadQuestions(at: [index])
        case .none:
            answeredQuestionsCount += 1
            break
        }
        
        view.showSubmit(answeredQuestionsCount > 0)
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
			                                                           current: question.question.answered?.value)))
		
		case .singleChoiceConditional(let answers), .singleChoice(let answers):
			let _answers = answers.map {Answer(title: $0.title, isSelected: $0.title == question.question.answered?.title)}
			return PTQuestionnaireViewItem(type: .answers(.singleChoice(answers: _answers)))		
		}
	}
    
}
