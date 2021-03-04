//
//  SizeCollectionViewCell.swift
//  AmIDrunk
//
//  Created by Robert Pinl on 14.02.2021.
//

import UIKit

class SizeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var sizeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 12
        
    }
}
