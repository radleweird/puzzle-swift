//
//  PreferencesManager.swift
//  puzzle-iOS
//
//  Created by Eldar Goloviznin on 25.11.17.
//  Copyright © 2017 Eldar Goloviznin. All rights reserved.
//

import Foundation

protocol PreferenceManagerSizeDelegate: class {
    func update()
}

protocol PreferencesManager {
    var preferenceManagerSizeDelegate: PreferenceManagerSizeDelegate? { get set }
    
    func settings(fieldSizeWriteWithValue: Int)
    func settingsFieldSize() -> Int
    func settings(cellColorwriteWithValue: String)
    func settingsCellColor() -> String
}

class PreferencesManagerDefault: PreferencesManager {
    
    weak var preferenceManagerSizeDelegate: PreferenceManagerSizeDelegate?
    
    init() {
        UserDefaults.standard.register(defaults: [UserDefaults.fieldSizeKey: 4, UserDefaults.cellColorKey: "#FFFFFF"])
    }
    
    func settings(fieldSizeWriteWithValue size: Int) {
        UserDefaults.standard.set(size, forKey: UserDefaults.fieldSizeKey)
        preferenceManagerSizeDelegate?.update()
    }
    
    func settingsFieldSize() -> Int {
        return UserDefaults.standard.integer(forKey: UserDefaults.fieldSizeKey)
    }
    
    func settings(cellColorwriteWithValue color: String) {
        UserDefaults.standard.set(color, forKey: UserDefaults.cellColorKey)
    }
    
    func settingsCellColor() -> String {
        return UserDefaults.standard.string(forKey: UserDefaults.cellColorKey)!
    }
    
    
}

private extension UserDefaults {
    
    static var fieldSizeKey: String {
        return "FieldSizeKey"
    }
    
    static var cellColorKey: String {
        return "CellColor"
    }
    
}
