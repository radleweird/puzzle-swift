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
    func puzzleSolved()
}

protocol PuzzlePresenter: class {
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
    private var field: Field
    private var finiteField: Field
    
    init(preferencesManager: PreferencesManager) {
        self.preferencesManager = preferencesManager
        let size = preferencesManager.settingsFieldSize()
        self.field = Field(size: size)!
        self.field.shuffle(times: 200)
        self.finiteField = Field(size: size)!
        self.preferencesManager.preferenceManagerSizeDelegate = self
    }
    
    func onNewGame() {
        generateFields()
        updateView()
    }
    
    func onSwipeUp() {
        handleSwipe(direction: .down)
    }
    
    func onSwipeRight() {
        handleSwipe(direction: .left)
    }
    
    func onSwipeDown() {
        handleSwipe(direction: .up)
    }
    
    func onSwipeLeft() {
        handleSwipe(direction: .right)
    }
    
}

extension PuzzlePresenterDefault: PreferenceManagerSizeDelegate {
    
    func update() {
        onNewGame()
    }
    
}

extension PuzzlePresenterDefault {
    
    private func generateFields() {
        let size = preferencesManager.settingsFieldSize()
        field = Field(size: size)!
        field.shuffle(times: 200)
        finiteField = Field(size: size)!
    }
    
    private func handleSwipe(direction: Direction) {
        if field != finiteField && field.move(to: direction) {
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
