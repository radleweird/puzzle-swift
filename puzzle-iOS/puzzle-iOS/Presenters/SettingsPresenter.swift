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

protocol SettingsSizeDelegate {
    func onSettingsSizeChanged(size: Int)
}

protocol SettingsCellColorDelegate {
    func onSettingsCellColorChanged(red: Int, green: Int, blue: Int, alpha: Int)
}

protocol SettingsPresenter {
    func settings(getWithIdentifier: Settings) -> String
    func settings(writeWithIdentifier: Settings, value: String)
}
