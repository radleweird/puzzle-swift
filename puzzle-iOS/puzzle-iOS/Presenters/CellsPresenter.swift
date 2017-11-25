//
//  CellPresenter.swift
//  puzzle-iOS
//
//  Created by Eldar Goloviznin on 25.11.17.
//  Copyright © 2017 Eldar Goloviznin. All rights reserved.
//

import Foundation

protocol Cell {
    func update(withColor: (red: Int, green: Int, blue: Int, alpha: Int))
    func update(withValue: Int)
}

protocol CellsPresenter {
    var cells: [PuzzleView?] { get set }
    
    func unregisterCells()
    func value(atIndex: Int) -> Int
}
