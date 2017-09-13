//
//  PTQuestionnaireCategoryHeaderView.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/13/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

class PTQuestionnaireCategoryHeaderView: UICollectionReusableView {

    @IBOutlet fileprivate var titleLable: UILabel!
    
    func setup(with title: String) {
        titleLable.text = title
    }
    
}
