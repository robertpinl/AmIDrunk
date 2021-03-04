//
//  VolumeCollectionViewCell.swift
//  AmIDrunk
//
//  Created by Robert Pinl on 14.02.2021.
//

import UIKit

class VolumeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 12
    }
}
