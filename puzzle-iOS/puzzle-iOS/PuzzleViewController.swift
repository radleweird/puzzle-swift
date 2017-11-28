//
//  PuzzleViewController.swift
//  puzzle-iOS
//
//  Created by Eldar Goloviznin on 26.11.17.
//  Copyright © 2017 Eldar Goloviznin. All rights reserved.
//

import UIKit

class PuzzleViewController: UIViewController {
    
    @IBOutlet weak var fieldView: UIView!
    
    private var fieldVC: FieldViewController?
    private var puzzlePresenter: PuzzlePresenter?
    private var fieldSize: Int = 0
    private var field: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        puzzlePresenter = PuzzlePresenterDefault(preferencesManager: PreferencesManagerDefault.shared)
        puzzlePresenter?.view = self
        
        let up = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeGesture(_:)))
        up.direction = .up
        let right = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeGesture(_:)))
        right.direction = .right
        let down = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeGesture(_:)))
        down.direction = .down
        let left = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeGesture(_:)))
        left.direction = .left
        fieldView.addGestureRecognizer(up)
        fieldView.addGestureRecognizer(right)
        fieldView.addGestureRecognizer(down)
        fieldView.addGestureRecognizer(left)
    }
    
    @objc func onSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case UISwipeGestureRecognizerDirection.up:
            puzzlePresenter?.onSwipeUp()
        case UISwipeGestureRecognizerDirection.right:
            puzzlePresenter?.onSwipeRight()
        case UISwipeGestureRecognizerDirection.down:
            puzzlePresenter?.onSwipeDown()
        case UISwipeGestureRecognizerDirection.left:
            puzzlePresenter?.onSwipeLeft()
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if fieldVC == nil && segue.destination is FieldViewController {
            fieldVC = segue.destination as? FieldViewController
        }
    }
    
}

extension PuzzleViewController: PuzzleView {
    
    func update(withSize size: Int) {
        fieldVC?.set(fieldSize: size)
    }
    
    func update(withField field: [Int]) {
        fieldVC?.set(field: field)
    }

    func puzzleSolved() {
    }
    
}

