//
//  Presenter.swift
//  puzzle-iOS
//
//  Created by Eldar Goloviznin on 25.11.17.
//  Copyright © 2017 Eldar Goloviznin. All rights reserved.
//

import Foundation

protocol PuzzleView {
    func onUpdate(size: Int)
    func onPuzzleSolved()
}

protocol PuzzleFieldChangedDelegate{
    func onFieldChanged(field: [Int])
}

protocol PuzzlePresenter {
    func onSwipeUp()
    func onSwipeRight()
    func onSwipeDown()
    func onSwipeLeft()
    func onHelpPressed()
    func onHelpReleased()
}
