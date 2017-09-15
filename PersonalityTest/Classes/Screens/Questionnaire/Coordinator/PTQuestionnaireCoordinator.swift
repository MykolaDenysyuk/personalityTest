//
//  PTQuestionnaireCoordinator.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/13/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

protocol PTQuestionnaireCoordinatorInterface {
    func showResults(_ result: [PTQuestionnaireResult], from vc: UIViewController, sender: UIView)
}

protocol PTQuestionnaireResultsCoordinatorInterface: class {
    func closeResults(sender: UIViewController)
}

class PTQuestionnaireCoordinator {
	
    // MARK: Actions
    
    func start(from window: UIWindow) {
        window.rootViewController = createController()
		window.makeKeyAndVisible()
    }
    
    func start(from controller: UIViewController) {
        controller.show(createController(),
                        sender: self)
    }
	
	fileprivate func createController() -> PTQuestionnaireViewController {
		if let ret = PTServices.storyboards.main
			.instantiateViewController(withIdentifier: "Questionnaire") as? PTQuestionnaireViewController {
			let datasource = PTQuestionnaireDatasource()
			ret.datasource = datasource
			ret.eventsHandler = datasource
            ret.coordinator = self
			return ret
		}
		fatalError("another view controller is expected")
	}
    
    fileprivate func createResultsController() -> PTQuestionnaireResultsViewController {
        if let ret = PTServices.storyboards.main
			.instantiateViewController(withIdentifier: "Results") as? PTQuestionnaireResultsViewController {
            ret.coordinator = self
            return ret
        }
        fatalError("another view controller is expected")
    }
    
}

extension PTQuestionnaireCoordinator: PTQuestionnaireCoordinatorInterface {
    func showResults(_ result: [PTQuestionnaireResult], from vc: UIViewController, sender: UIView) {
        let controller = createResultsController()
        controller.results = result
        let container = UINavigationController(rootViewController: controller)
        container.modalPresentationStyle = .popover
        if let popover = container.popoverPresentationController {
            popover.sourceView = sender
            popover.sourceRect = sender.bounds
        }
        vc.present(container,
                   animated: true,
                   completion: nil)
    }
}

extension PTQuestionnaireCoordinator: PTQuestionnaireResultsCoordinatorInterface {
    func closeResults(sender: UIViewController) {
        sender.dismiss(animated: true,
                       completion: nil)
    }
}
