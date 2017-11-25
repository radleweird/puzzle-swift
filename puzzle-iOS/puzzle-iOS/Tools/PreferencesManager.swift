//
//  PreferencesManager.swift
//  puzzle-iOS
//
//  Created by Eldar Goloviznin on 25.11.17.
//  Copyright © 2017 Eldar Goloviznin. All rights reserved.
//

import Foundation

protocol PreferencesManager {
    func settings(withIdentifier: String) -> String
}
