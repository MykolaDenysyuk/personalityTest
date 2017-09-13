//
//  PTQuestionnaireCoordinator.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/13/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit


class PTQuestionnaireCoordinator {
    
    // MARK: Vars
    
    fileprivate lazy var viewController: PTQuestionnaireViewController = {
       if let ret = UIStoryboard(name: "Main", bundle: nil)
        .instantiateViewController(withIdentifier: "Questionnaire") as? PTQuestionnaireViewController {
        return ret
        }
        fatalError("another view controller is expected")
    }()
    
    
    // MARK: Actions
    
    func start(from window: UIWindow) {
        
    }
    
    func start(from controller: UIViewController) {
        
    }
    
}
