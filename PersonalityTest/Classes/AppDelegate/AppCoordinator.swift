//
//  AppCoordinator.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/12/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

class AppCoordinator {
    let window: UIWindow
    fileprivate(set) var rootController: UIViewController!
    
    init(with window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let questionnaire = PTQuestionnaireCoordinator()
        questionnaire.start(from: window)
    }
}
