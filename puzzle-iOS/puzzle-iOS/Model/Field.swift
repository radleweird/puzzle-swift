//
//  Field.swift
//  puzzle-iOS
//
//  Created by Eldar Goloviznin on 25.11.17.
//  Copyright © 2017 Eldar Goloviznin. All rights reserved.
//

import Foundation

enum Direction: Int {
    case up, right, down, left
}

class Field<Cell: Equatable>: Equatable {
    
    private(set) var field: [Cell] = []
    private var zeroPos: Int!
    var size: Int {
        didSet {
            configureFieldArrangement()
        }
    }
    var fieldSource: FieldSource<Cell>? {
        didSet {
            configureFieldArrangement()
        }
    }
    
    init?(size: Int) {
        guard size > 1 else {
            return nil
        }
        self.size = size
    }
    
    func move(to direction: Direction) -> Bool {
        let zeroCoords = convertToCoords(fromPos: zeroPos)
        var offset: (x: Int, y: Int)!
        
        switch direction {
        case .up:
            guard zeroCoords.y != 0 else {
                return false
            }
            offset = (x: 0, y: -1)
        case .right:
            guard zeroCoords.x != size - 1 else {
                return false
            }
            offset = (x: 1, y: 0)
        case .down:
            guard zeroCoords.y != size - 1 else {
                return false
            }
            offset = (x: 0, y: 1)
        case.left:
            guard zeroCoords.x != 0 else {
                return false
            }
            offset = (x: -1, y: 0)
        }
        
        let newZeroPos = zeroPos + convertToPos(fromCoords: offset)
        swap(firstIndex: zeroPos, secondIndex: newZeroPos)
        zeroPos = newZeroPos
        return true
    }
    
    static func ==(lhs: Field, rhs: Field) -> Bool {
        return lhs.size == rhs.size && lhs.field == rhs.field
    }
    
}

extension Field {
    
    func shuffle(times: Int) {
        var movesCounter = 0
        while times != movesCounter {
            let dir = Direction(rawValue: Int(arc4random_uniform(4)))!
            if move(to: dir) {
                movesCounter += 1
            }
        }
    }
    
}

private extension Field {
    
    func configureFieldArrangement() {
        field = []
        guard let fieldSource = fieldSource else {
            return
        }
        for idx in 0..<size * size {
            field.append(fieldSource.cell(forIndex: idx))
        }
        zeroPos = field.count - 1
    }
    
    func swap(firstIndex: Int, secondIndex: Int) {
        let temp = field[firstIndex]
        field[firstIndex] = field[secondIndex]
        field[secondIndex] = temp
    }
    
}

private extension Field {
    
    func convertToCoords(fromPos pos: Int) -> (x: Int, y: Int) {
        return (pos % size, pos / size)
    }
    
    func convertToPos(fromCoords coords: (x: Int, y: Int)) -> Int {
        return coords.x + coords.y * size
    }
    
}
