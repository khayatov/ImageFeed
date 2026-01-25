//
//  ProfileLogoutService.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 21.01.26.
//

import Foundation
import WebKit

final class ProfileLogoutService: ProfileLogoutServiceProtocol {
    // MARK: - Private Properties
    private let oauth2Service = OAuth2Service.shared
    private let oAuth2TokenStorage = OAuth2TokenStorage.shared
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private let imagesListService = ImagesListService.shared
    
    // MARK: - Public Properties
    static let shared = ProfileLogoutService()
    
    // MARK: - Initializers
    private init() {}
    
    // MARK: - Public Methods
    func logout() {
        oauth2Service.cleanData()
        oAuth2TokenStorage.token = nil
        profileService.cleanData()
        profileImageService.cleanData()
        imagesListService.cleanData()
        cleanCookies()
        
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Invalid window configuration")
            return
        }
        window.rootViewController = SplashViewController()
        window.makeKeyAndVisible()
    }
    
    // MARK: - Private Methods
    private func cleanCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
}
