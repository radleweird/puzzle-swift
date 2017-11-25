//
//  CellPresenter.swift
//  puzzle-iOS
//
//  Created by Eldar Goloviznin on 25.11.17.
//  Copyright © 2017 Eldar Goloviznin. All rights reserved.
//

import Foundation

protocol Cell {
    func onColorUpdate(red: Int, green: Int, blue: Int, alpha: Int)
    func onValueUpdate(value: Int)
}

protocol CellsPresenter {
    func registerCell(cell: Cell)
    func inregisterCells()
    func value(atIndex: Int) -> Int
}
