//
//  CellPresenter.swift
//  puzzle-iOS
//
//  Created by Eldar Goloviznin on 25.11.17.
//  Copyright © 2017 Eldar Goloviznin. All rights reserved.
//

import Foundation

protocol Cell {
    func changeColor(red: Int, green: Int, blue: Int, alpha: Int)
}

protocol CellsPresenter {
    func value(atIndex: Int) -> Int
}
