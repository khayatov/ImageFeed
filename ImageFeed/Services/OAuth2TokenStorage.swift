//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 21.12.25.
//

import Foundation

final class OAuth2TokenStorage {
    // MARK: - Public Properties
    var token: String? {
        get {
            userDefaults.string(forKey: Keys.token.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.token.rawValue)
        }
    }
    
    // MARK: - Private Properties
    private let userDefaults: UserDefaults = .standard
    private enum Keys: String {
        case token
    }
}
