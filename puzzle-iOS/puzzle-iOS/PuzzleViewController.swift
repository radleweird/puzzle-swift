//
//  PuzzleViewController.swift
//  puzzle-iOS
//
//  Created by Eldar Goloviznin on 26.11.17.
//  Copyright © 2017 Eldar Goloviznin. All rights reserved.
//

import UIKit

class PuzzleViewController: UICollectionViewController {
    
    private var puzzlePresenter: PuzzlePresenter?
    private var fieldSize: Int = 0
    private var field: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.isScrollEnabled = false
        
        let upSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeGesture(_:)))
        upSwipeRecognizer.direction = .up
        let rightSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeGesture(_:)))
        rightSwipeRecognizer.direction = .right
        let downSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeGesture(_:)))
        downSwipeRecognizer.direction = .down
        let leftSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeGesture(_:)))
        leftSwipeRecognizer.direction = .left
        collectionView?.addGestureRecognizer(upSwipeRecognizer)
        collectionView?.addGestureRecognizer(rightSwipeRecognizer)
        collectionView?.addGestureRecognizer(downSwipeRecognizer)
        collectionView?.addGestureRecognizer(leftSwipeRecognizer)
        
        puzzlePresenter = PuzzlePresenterDefault(preferencesManager: PreferencesManagerDefault.shared)
        puzzlePresenter?.view = self
    }
    
    @IBAction func onSwipeGesture(_ sender: UISwipeGestureRecognizer) {
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
    
}

extension PuzzleViewController: PuzzleView {
    
    func update(withSize size: Int) {
        self.fieldSize = size
    }
    
    func update(withField field: [Int]) {
        self.field = field
        collectionView?.reloadData()
    }

    func puzzleSolved() {
    }
    
}

extension PuzzleViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fieldSize
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fieldSize
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionView.identifierOfCell, for: indexPath) as! ViewCell
        cell.setNumber(number: field[indexPath.section * fieldSize + indexPath.row])
        
        return cell
    }
}

extension PuzzleViewController: UICollectionViewDelegateFlowLayout {
      
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthAndHeight = view.frame.width / CGFloat(fieldSize)
        return CGSize(width: widthAndHeight, height: widthAndHeight)
    }
    
}

private extension UICollectionView {
    
    static var identifierOfCell: String {
        return "identifierOfCell"
    }
    
}
