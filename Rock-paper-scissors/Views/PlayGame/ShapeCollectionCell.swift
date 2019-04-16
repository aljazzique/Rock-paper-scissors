//
//  ShapeCollectionCell.swift
//  Rock-paper-scissors
//
//  Created by alexandre ulas on 12/04/2019.
//  Copyright © 2019 Alexandre.ulas. All rights reserved.
//

import UIKit

class ShapeCollectionCell:UICollectionViewCell {
    static let reusableIdentifier = "shapeCollectionCell"
    static let nibName = "ShapeCollectionCell"
    
    @IBOutlet weak var shapeLabel: UILabel!
    
    func fillUI(_ shape:String) {
        shapeLabel.text = shape
    }
}
