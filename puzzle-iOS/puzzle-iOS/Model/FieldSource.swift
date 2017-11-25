//
//  FieldSource.swift
//  puzzle-iOS
//
//  Created by Eldar Goloviznin on 25.11.17.
//  Copyright © 2017 Eldar Goloviznin. All rights reserved.
//

import Foundation

class FieldSource<Cell> {
    
    private let source: [Cell]
    
    init(source: [Cell]) {
        self.source = source
    }
    
    func cell(forIndex index: Int) -> Cell {
        return source[index % source.count]
    }
    
}
