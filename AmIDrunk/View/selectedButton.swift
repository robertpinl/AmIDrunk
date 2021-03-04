//
//  selectedButton.swift
//  AmIDrunk
//
//  Created by Robert Pinl on 28.02.2021.
//

import UIKit

class selectedButton: UIButton {
    
    override func awakeFromNib() {
        layer.cornerRadius = 12
        tintColor = .clear
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .selectedButtonBackground
                layer.borderWidth = 2
                layer.borderColor = UIColor.darkBlue.cgColor
            } else {
                backgroundColor = .darkBlue
                layer.borderWidth = 0
            }
        }
    }
}
