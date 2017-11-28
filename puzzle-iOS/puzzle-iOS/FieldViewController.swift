//
//  FieldViewController.swift
//  puzzle-iOS
//
//  Created by Eldar Goloviznin on 28.11.17.
//  Copyright © 2017 Eldar Goloviznin. All rights reserved.
//

import UIKit

class FieldViewController: UIViewController {
    
    private var useForceSetup = true
    private var fieldSize: Int = 0
    private var field: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func set(fieldSize: Int) {
        view.subviews.forEach({ cell in
            if cell.tag >= tag(forIndex: 0) {
                var outFrame = frameForCell(withIndex: index(forTag: cell.tag))
                outFrame.origin.x = outFrame.origin.x + view.frame.width // make cell go out from visible part. [->]
                cell.tag = Int.max // prevent misleading with new cells
                UIView.animate(withDuration: Double.disAppearingDuration, animations: {
                    cell.frame = outFrame
                }, completion: { (_) in
                    cell.removeFromSuperview()
                })
            } else {
                cell.removeFromSuperview()
            }
        })
        
        self.fieldSize = fieldSize
        let cellSize = getCellSize()
        print(cellSize)
        for idx in 0..<fieldSize * fieldSize {
            let cell = UIButton()
            let frame = frameForCell(withIndex: idx)
            var initialFrame = frame
            initialFrame.origin.x = initialFrame.origin.x - view.frame.width  // make cell come in from invisible part. [->]
            cell.frame = initialFrame
            cell.tag = tag(forIndex: idx)
            UIView.animate(withDuration: Double.appearingDuration, animations: {
                cell.frame = frame
            })
            view.addSubview(cell)
        }
        
        useForceSetup = true
    }
    
    func set(field: [Int]) {
        if useForceSetup {
            useForceSetup = false
            self.field = field
            for (idx, num) in field.enumerated() {
                let cell = view.viewWithTag(tag(forIndex: idx)) as! UIButton
                switch num {
                case 0:
                    cell.removeFromSuperview()
                default:
                    cell.setTitle(String(num), for: .normal)
                    cell.backgroundColor = UIColor.orange
                }
            }
        } else {
            let oldField = self.field
            self.field = field
            let oldZeroIndex = oldField.index(of: 0)!
            let newZeroIndex = field.index(of: 0)!
            replaceZero(fromIndex: oldZeroIndex, toIndex: newZeroIndex)
        }
    }
    
}

private extension FieldViewController {
    
    func tag(forIndex index: Int) -> Int {
        return index + 25
    }
    
    func index(forTag: Int) -> Int {
        return forTag - tag(forIndex: 0)
    }
    
    func getCellSize() -> CGSize {
        let widthAndHeight = view.frame.width / CGFloat(self.fieldSize)
        return CGSize(width: widthAndHeight, height: widthAndHeight)
    }
    
    func frameForCell(withIndex idx: Int) -> CGRect {
        let cellSize = getCellSize()
        let x = CGFloat(idx % self.fieldSize) * cellSize.width
        let y = CGFloat(idx / self.fieldSize) * cellSize.width
        let pos = CGPoint(x: x, y: y)
        return CGRect(origin: pos, size: cellSize)
    }
    
    func replaceZero(fromIndex: Int, toIndex: Int) {
        let cellTo = view.viewWithTag(tag(forIndex: toIndex))!
        cellTo.tag = tag(forIndex: fromIndex)
        
        let frame = frameForCell(withIndex: fromIndex)
        UIView.animate(withDuration: Double.translationDuration) {
            cellTo.frame = frame
        }
    }
    
}

private extension Double {
    
    static var appearingDuration: Double {
        return 0.5
    }
    
    static var disAppearingDuration: Double {
        return 0.2
    }
    
    static var translationDuration: Double {
        return 0.1
    }
}
