//
//  SettingsPresenter.swift
//  puzzle-iOS
//
//  Created by Eldar Goloviznin on 25.11.17.
//  Copyright © 2017 Eldar Goloviznin. All rights reserved.
//

import Foundation

enum Settings {
    case fieldSize, cellColor
}

protocol SettingsView {
    func update(withIdentifier: Settings, value: String)
}

protocol SettingsSizeDelegate {
    func settingsUpdate(withSize: Int)
}

protocol SettingsCellColorDelegate {
    func settingsUpdate(withColor: (red: Int, green: Int, blue: Int, alpha: Int))
}

protocol SettingsPresenter {
    func settings(writeWithIdentifier: Settings, value: String)
}
