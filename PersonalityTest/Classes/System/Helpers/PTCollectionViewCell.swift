//
//  PTCollectionViewCell.swift
//  PersonalityTest
//
//  Created by Mykola Denysyuk on 9/13/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

protocol PTCollectionViewCellDelegate: class {
    func cell(_ cell: PTCollectionViewCell, requireNewHeight: CGFloat)
}

class PTCollectionViewCell: UICollectionViewCell {
    weak var delegate: PTCollectionViewCellDelegate?
    
    func setNeedsNewHeight(height: CGFloat) {
        delegate?.cell(self, requireNewHeight: height)
    }
}
