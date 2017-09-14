//
//  PTQuestionnaireCoordinator.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/13/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit


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
		if let ret = UIStoryboard(name: "Main", bundle: nil)
			.instantiateViewController(withIdentifier: "Questionnaire") as? PTQuestionnaireViewController {
			let datasource = PTQuestionnaireDatasource()
			ret.datasource = datasource
			ret.eventsHandler = datasource
			return ret
		}
		fatalError("another view controller is expected")
	}
    
}
