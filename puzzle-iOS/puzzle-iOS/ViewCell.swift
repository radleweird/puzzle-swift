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
            cell?.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        default:
            cell?.text = String(number)
            cell?.backgroundColor = UIColor.yellow
        }
    }
    
}
