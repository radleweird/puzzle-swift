//
//  Presenter.swift
//  puzzle-iOS
//
//  Created by Eldar Goloviznin on 25.11.17.
//  Copyright © 2017 Eldar Goloviznin. All rights reserved.
//

import Foundation

protocol PuzzleView: class {
    func update(withSize: Int)
    func update(withField: [Int])
    func update(withTranslation: (from: Int, to: Int))
    func puzzleSolved()
}

protocol PuzzlePresenter {
    var view: PuzzleView? { get set }
    
    func onNewGame()
    func onSwipeUp()
    func onSwipeRight()
    func onSwipeDown()
    func onSwipeLeft()
}

class PuzzlePresenterDefault: PuzzlePresenter {
    
    var view: PuzzleView? {
        didSet {
            updateView()
        }
    }
    
    private let preferencesManager: PreferencesManager
    private var field: Field<Int>!
    private var finiteField: Field<Int>!
    
    init(preferencesManager: PreferencesManager) {
        self.preferencesManager = preferencesManager
        generateFields()
    }
    
    func onNewGame() {
        generateFields()
        updateView()
    }
    
    func onSwipeUp() {
        handleSwipe(direction: .up)
    }
    
    func onSwipeRight() {
        handleSwipe(direction: .right)
    }
    
    func onSwipeDown() {
        handleSwipe(direction: .down)
    }
    
    func onSwipeLeft() {
        handleSwipe(direction: .left)
    }
    
}

extension PuzzlePresenterDefault: PreferenceManagerSizeDelegate {
    
    func update() {
        generateFields()
        updateView()
    }
    
}

extension PuzzlePresenterDefault {
    
    private func generateFields() {
        let size = preferencesManager.settingsFieldSize()
        let fieldSource = FieldSource(source: generateIntSourceArray(withSize: size))
        field = Field<Int>(size: size)!
        field.fieldSource = fieldSource
        finiteField = Field<Int>(size: size)!
        finiteField.fieldSource = fieldSource
        finiteField.shuffle(times: 200)
    }
    
    private func generateIntSourceArray(withSize size: Int) -> [Int] {
        var arr = Array(1...size * size)
        arr[arr.count - 1] = 0
        return arr
    }
    
    private func handleSwipe(direction: Direction) {
        if field != finiteField && field.move(to: direction) {
            // MARK: - TODO: REPLACE WITH TRANSLATIONS
            view?.update(withField: field.field)
            if field == finiteField {
                view?.puzzleSolved()
            }
        }
    }
    
    private func updateView() {
        view?.update(withSize: preferencesManager.settingsFieldSize())
        view?.update(withField: field.field)
    }

}
