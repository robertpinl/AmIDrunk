//
//  SelectedCollectionViewCell.swift
//  AmIDrunk
//
//  Created by Robert Pinl on 20.02.2021.
//

import UIKit

class SelectedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var selectedDrinkLabel: UILabel!
    @IBOutlet weak var selectedSizeLabel: UILabel!
    @IBOutlet weak var selectedVolumeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 12
    }
}
