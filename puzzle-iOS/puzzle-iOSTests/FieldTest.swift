//
//  puzzle_iOSTests.swift
//  puzzle-iOSTests
//
//  Created by Eldar Goloviznin on 25.11.17.
//  Copyright © 2017 Eldar Goloviznin. All rights reserved.
//

import XCTest
@testable import puzzle_iOS

class puzzle_iOSTests: XCTestCase {
    
    var field: Field<Int>!
    var fieldSource: FieldSource<Int>!
    
    override func setUp() {
        super.setUp()
        
        field = Field<Int>(size: 3)!
        fieldSource = FieldSource(source: [1, 2, 3, 4, 5, 6, 7, 8, 0])
        field.fieldSource = fieldSource
    }
    
    func test_suitableSource_getField_equalsSource() {
        field.size = 3
        
        XCTAssertEqual(field.field, [1, 2, 3, 4, 5, 6, 7, 8, 0])
    }
    
    func test_tooSmallSource_getField_repeatingSource() {
        field.size = 4
        
        XCTAssertEqual(field.field, [1, 2, 3, 4, 5, 6, 7, 8, 0, 1, 2, 3, 4, 5, 6, 7])
    }
    
    func test_noSource_getField_empty() {
        field.fieldSource = nil
        
        XCTAssertEqual(field.field, [])
    }
    
    func test_tooSmallOrNegativeFieldSize_checkFieldIsNil_Nil() {
        for size in -10...1 {
            let myField = Field<Int>(size: size)
            
            XCTAssertNil(myField)
        }
    }
    
    func test_twoFieldAreTheSame_checkThem_same() {
        let oneField = Field<Int>(size: 3)!
        oneField.fieldSource = fieldSource
        let anotherField = Field<Int>(size: 3)!
        anotherField.fieldSource = fieldSource
    
        XCTAssertEqual(oneField, anotherField)
    }
    
    func test_twoFieldWithDifferentSizeAreNotTheSame_checkThem_not() {
        let oneField = Field<Int>(size: 4)!
        oneField.fieldSource = fieldSource
        let anotherField = Field<Int>(size: 3)!
        anotherField.fieldSource = fieldSource
        
        XCTAssertNotEqual(oneField, anotherField)
    }
    
    func test_twoFieldWithDifferentSourceAreNotTheSame_checkThem_not() {
        let oneField = Field<Int>(size: 4)!
        oneField.fieldSource = fieldSource
        let anotherField = Field<Int>(size: 3)!
        anotherField.fieldSource = FieldSource(source: [1, 2, 3, 4, 5, 6, 7, 8, 0].reversed())
        
        XCTAssertNotEqual(oneField, anotherField)
    }
    
    func test_doMove_check_equal() {
        field.fieldSource = FieldSource(source:
                [2, 4, 5] +
                [1, 7, 3] +
                [8, 6, 0])
        
        _ = field.move(to: .up)
        
        XCTAssertEqual(field.field,
                [2, 4, 5] +
                [1, 7, 0] +
                [8, 6, 3])
        
        _ = field.move(to: .left)
        
        XCTAssertEqual(field.field,
                [2, 4, 5] +
                [1, 0, 7] +
                [8, 6, 3])
        
        _ = field.move(to: .down)
        
        XCTAssertEqual(field.field,
                [2, 4, 5] +
                [1, 6, 7] +
                [8, 0, 3])
        
        _ = field.move(to: .right)
        
        XCTAssertEqual(field.field,
                [2, 4, 5] +
                [1, 6, 7] +
                [8, 3, 0])
    }
    
    func test_doMoveIntoWallEdge_check_keepInBounds() {
        field.fieldSource = FieldSource(source:
                [2, 4, 5] +
                [1, 7, 3] +
                [8, 6, 0])
        
        _ = field.move(to: .right)
        _ = field.move(to: .down)
        
        XCTAssertEqual(field.field,
                [2, 4, 5] +
                [1, 7, 3] +
                [8, 6, 0])
        
        _ = field.move(to: .left)
        _ = field.move(to: .left)
        _ = field.move(to: .left)
        _ = field.move(to: .down)
        
        XCTAssertEqual(field.field,
                [2, 4, 5] +
                [1, 7, 3] +
                [0, 8, 6])
        
        _ = field.move(to: .up)
        _ = field.move(to: .up)
        _ = field.move(to: .up)
        _ = field.move(to: .left)
        
        XCTAssertEqual(field.field,
                [0, 4, 5] +
                [2, 7, 3] +
                [1, 8, 6])
        
        _ = field.move(to: .right)
        _ = field.move(to: .right)
        _ = field.move(to: .right)
        _ = field.move(to: .up)
        
        XCTAssertEqual(field.field,
                [4, 5, 0] +
                [2, 7, 3] +
                [1, 8, 6])
        
        _ = field.move(to: .down)
        _ = field.move(to: .down)
        _ = field.move(to: .down)
        _ = field.move(to: .right)
        
        XCTAssertEqual(field.field,
                [4, 5, 3] +
                [2, 7, 6] +
                [1, 8, 0])
    }
    
    func test_tryShuffle() {
        let anotherField = Field<Int>(size: 3)!
        anotherField.fieldSource = fieldSource
        anotherField.shuffle(times: 200)
        
        XCTAssertNotEqual(anotherField, field)
        
    }
    
}
