//
//  SettingsPresenter.swift
//  puzzle-iOS
//
//  Created by Eldar Goloviznin on 25.11.17.
//  Copyright © 2017 Eldar Goloviznin. All rights reserved.
//

import Foundation

protocol SettingsView: class {
    func update(fieldSizeWithValue: Int)
    func update(updateCellColorWithValue: String)
}

protocol SettingsPresenter {
    var view: SettingsView? { get set }
    
    func settings(fieldSizeChange: Int)
    func settings(cellColorChange: String)
}

class SettingsPresenterDefault: SettingsPresenter {
    
    weak var view: SettingsView? {
        didSet {
            view?.update(fieldSizeWithValue: preferencesManager.settingsFieldSize())
            view?.update(updateCellColorWithValue: preferencesManager.settingsCellColor())
        }
    }
    
    let preferencesManager: PreferencesManager
    
    init(preferencesManager: PreferencesManager) {
        self.preferencesManager = preferencesManager
    }
    
    func settings(fieldSizeChange size: Int) {
        preferencesManager.settings(fieldSizeWriteWithValue: size)
    }
    
    func settings(cellColorChange color: String) {
        preferencesManager.settings(cellColorwriteWithValue: color)
    }
    
    
}
