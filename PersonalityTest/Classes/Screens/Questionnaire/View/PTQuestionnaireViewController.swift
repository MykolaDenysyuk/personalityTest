//
//  PTQuestionnaireViewController.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/13/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

class PTQuestionnaireViewController: UIViewController {

    // MARK: Vars
    
    fileprivate let cellIdentifier = (question: "question", answers: "answers")
    fileprivate let headerIndentifier = "header"
    @IBOutlet fileprivate weak var collectionView: UICollectionView! {
        didSet {
            let nib = UINib(nibName: "PTQuestionnaireCategoryHeaderView",
                            bundle: nil)
			collectionView.layoutMargins = .zero
            collectionView.register(nib,
                                    forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                    withReuseIdentifier: headerIndentifier)
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    var datasource: PTQuestionnaireViewDatasourceInterface!
    weak var eventsHandler: PTQuestionnaireViewOutput?
	lazy var layout: PTQuestionnaireViewLayout = {
		return PTQuestionnaireViewLayout(container: self.collectionView)
	}()
	
    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        eventsHandler?.viewRequiresData(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size,
		                         with: coordinator)
		collectionView.collectionViewLayout.invalidateLayout()
		coordinator.animate(alongsideTransition: { _ in
			self.collectionView.layoutIfNeeded()
			self.layout.invalidate()
		}, completion: nil)
	}
	
}

extension PTQuestionnaireViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return layout.sizeForItem(at: indexPath.item)
    }
	
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datasource.numberOfCategories()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                   withReuseIdentifier: headerIndentifier,
                                                                   for: indexPath)
        if let header = view as? PTQuestionnaireCategoryHeaderView {
            header.setup(with: datasource.title(for: indexPath.section))
        }
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.numberOfQuestions(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        func dequeueCell<T>(with identifier: String) -> T  where T: UICollectionViewCell {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                                             for: indexPath) as? T {
                return cell
            }
            fatalError("cell of type \(T.self) is not registered with collection view")
        }
        
        let viewItem = datasource.question(at: indexPath)
        
        switch viewItem.type {
        case .question(let question):
            let cell: PTQuestionViewCell = dequeueCell(with: cellIdentifier.question)
            cell.setup(with: question)
            return cell
        case .answers(let type):
            let cell: PTAnswersViewCell = dequeueCell(with: cellIdentifier.answers)
            cell.setup(with: type)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? PTCollectionViewCell {
            cell.delegate = self
        }
    }
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.reloadItems(at: [indexPath])
	}
    
}

extension PTQuestionnaireViewController: PTCollectionViewCellDelegate {
    func cell(_ cell: PTCollectionViewCell, requireNewHeight: CGFloat) {
        if let index = collectionView.indexPath(for: cell) {
            layout.update(height: requireNewHeight, forItemAt: index.item)
			collectionView.reloadItems(at: [index])
        }
    }
}

extension PTQuestionnaireViewController: PTAnswersViewCellDelegate {
    func answersCell(_ cell: PTAnswersViewCell, didSelectAnswer answer: Int) {
        if let index = collectionView.indexPath(for: cell) {
            eventsHandler?.view(self,
                                didSelectAnswer: answer,
                                forQuestionAt: index)
        }
    }
}

extension PTQuestionnaireViewController: PTQuestionnaireViewIntput {
    
    func reload() {
		DispatchQueue.main.async {
			self.collectionView.reloadData()
		}
    }
    
    func reloadQuestions(at indexes: [IndexPath]) {
		DispatchQueue.main.async {
			self.collectionView.reloadItems(at: indexes)
		}
    }
    
    func reloadCategory(at index: Int) {
		DispatchQueue.main.async {
			
		}
        collectionView.reloadSections([index])
    }
    
    func insertNewQuestions(at indexes: [IndexPath]) {
		DispatchQueue.main.async {
			
		}
    }
    
    func removeQuestions(at indexes: [IndexPath]) {
		DispatchQueue.main.async {
			self.collectionView.deleteItems(at: indexes)
		}
    }
    
}
