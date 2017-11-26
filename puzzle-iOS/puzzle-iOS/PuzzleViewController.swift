//
//  PuzzleViewController.swift
//  puzzle-iOS
//
//  Created by Eldar Goloviznin on 26.11.17.
//  Copyright © 2017 Eldar Goloviznin. All rights reserved.
//

import UIKit

class PuzzleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension PuzzleViewController: PuzzleView {
    
    func update(withSize: Int) {
    }
    
    func update(withField: [Int]) {
    }
    
    func update(withTranslation: (from: Int, to: Int)) {
    }
    
    func puzzleSolved() {
    }
    
    
}
