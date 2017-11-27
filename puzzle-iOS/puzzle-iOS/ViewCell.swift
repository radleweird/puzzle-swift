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
        switch number {
        case 0:
            cell?.text = ""
        default:
            cell?.text = String(number)
            cell?.backgroundColor = UIColor.yellow
        }
    }
    
}
