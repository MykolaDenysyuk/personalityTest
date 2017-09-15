//
//  TestLayoutContainer.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/15/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

class TestLayoutContainer: PTLayoutContainerInterface {

    var frame: CGRect
    var traitCollection: UITraitCollection
    
    init(with frame: CGRect, and sizeClass: UITraitCollection) {
        self.frame = frame
        self.traitCollection = sizeClass
    }
    
}
