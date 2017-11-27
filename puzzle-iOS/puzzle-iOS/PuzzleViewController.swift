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
    private var isFieldChanged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.isScrollEnabled = false
        collectionView?.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        
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
        self.isFieldChanged = true
    }
    
    func update(withField field: [Int]) {
        let oldState = self.field
        self.field = field
        
        if isFieldChanged {
            collectionView?.reloadData()
            self.isFieldChanged = false
            return
        }
        
        let from = oldState.index(of: 0)!
        let to = self.field.index(of: 0)!
        let fromIndexPath = IndexPath(row: from % fieldSize, section: from / fieldSize)
        let toIndexPath = IndexPath(row: to % fieldSize, section: to / fieldSize)
        
        collectionView?.moveItem(at: fromIndexPath, to: toIndexPath)
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
    
    private var availableHeight: CGFloat {
        return view.frame.height - (tabBarController?.tabBar.frame.height ?? 0) - (navigationController?.navigationBar.frame.height ?? 0)
    }
    
    private var availableWidth: CGFloat {
        return view.frame.width
    }
    
    private var defaultSectionInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return defaultSectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = defaultSectionInsets.left * CGFloat(fieldSize + 1)
        let availableSpace = min(availableWidth, availableHeight) - paddingSpace
        let widthAndHeight = availableSpace / CGFloat(fieldSize)
        return CGSize(width: widthAndHeight, height: widthAndHeight)
    }
    
}

private extension UICollectionView {
    
    static var identifierOfCell: String {
        return "identifierOfCell"
    }
    
}
