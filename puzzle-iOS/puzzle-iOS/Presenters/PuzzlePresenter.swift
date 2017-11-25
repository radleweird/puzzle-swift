//
//  Presenter.swift
//  puzzle-iOS
//
//  Created by Eldar Goloviznin on 25.11.17.
//  Copyright © 2017 Eldar Goloviznin. All rights reserved.
//

import Foundation

protocol PuzzleView {
    func update(withSize: Int)
    func puzzleSolved()
}

protocol PuzzleFieldChangedDelegate{
    func changes(withField: [Int])
}

protocol PuzzlePresenter {
    var view: PuzzleView? { get set }
    
    func onSwipeUp()
    func onSwipeRight()
    func onSwipeDown()
    func onSwipeLeft()
    func onHelpPressed()
    func onHelpReleased()
}
