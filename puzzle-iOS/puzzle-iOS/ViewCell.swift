//
//  ViewCell.swift
//  puzzle-iOS
//
//  Created by Eldar Goloviznin on 27.11.17.
//  Copyright © 2017 Eldar Goloviznin. All rights reserved.
//

import UIKit

class ViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cell: UILabel? {
        didSet {
            cell?.adjustsFontSizeToFitWidth = true
        }
    }
    
    func setNumber(number: Int) {
        cell?.text = number != 0 ? String(number) : ""
    }
    
}
