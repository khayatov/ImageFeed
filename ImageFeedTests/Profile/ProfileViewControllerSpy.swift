//
//  ProfileViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by Andrey Khayatov on 25.01.26.
//

import ImageFeed
import Foundation
import UIKit

final class ProfileViewControllerSpy: ProfileViewControllerProtocol {
    var presenter: ProfilePresenterProtocol?
    var setupViewCalled: Bool = false
    var showLogoutAlertCalled: Bool = false
    var setupAvatarCalled: Bool = false
    
    func configure(_ presenter: any ImageFeed.ProfilePresenterProtocol) {
        self.presenter = presenter
        self.presenter?.view = self
    }
    
    func setupView(userName: String, userNickname: String, userAbout: String) {
        setupViewCalled = true
    }
    
    func showLogoutAlert(alertController: UIAlertController) {
        showLogoutAlertCalled = true
    }
    
    func setupAvatar(_ imageUrl: URL) {
        setupAvatarCalled = true
    }
}
