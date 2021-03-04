//
//  DrinkCollectionViewCell.swift
//  AmIDrunk
//
//  Created by Robert Pinl on 14.02.2021.
//

import UIKit

class DrinkCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var drinkLabel: UILabel!
    @IBOutlet weak var drinkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 18
    }
}
