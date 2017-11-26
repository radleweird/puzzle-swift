//
//  SettingsViewController.swift
//  puzzle-iOS
//
//  Created by Eldar Goloviznin on 26.11.17.
//  Copyright © 2017 Eldar Goloviznin. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    private var settingsPresenter: SettingsPresenter?
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsPresenter = SettingsPresenterDefault(preferencesManager: PreferencesManagerDefault())
        settingsPresenter?.view = self
    }

    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            settingsPresenter?.settings(fieldSizeChange: 3)
        case 1:
            settingsPresenter?.settings(fieldSizeChange: 4)
        case 2:
            settingsPresenter?.settings(fieldSizeChange: 5)
        default:
            break
        }
    }
}

extension SettingsViewController: SettingsView {
    
    func update(fieldSizeWithValue size: Int) {
        switch size {
        case 3:
            segmentedControl.selectedSegmentIndex = 0
        case 4:
            segmentedControl.selectedSegmentIndex = 1
        case 5:
            segmentedControl.selectedSegmentIndex = 2
        default:
            break
        }
    }
    
    
    func update(updateCellColorWithValue color: String) {
        colorLabel.text = color
    }
    
}
