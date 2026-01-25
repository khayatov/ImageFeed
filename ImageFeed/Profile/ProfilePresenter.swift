//
//  ProfilePresenter.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 25.01.26.
//

import Foundation
import UIKit

final class ProfilePresenter: ProfilePresenterProtocol {
    // MARK: - Public Properties
    weak var view: ProfileViewControllerProtocol?
    
    // MARK: - Private Properties
    private let profileService: ProfileServiceProtocol?
    private let profileImageService: ProfileImageServiceProtocol?
    private let profileLogoutService: ProfileLogoutServiceProtocol?
    private var profileImageServiceObserver: NSObjectProtocol?
    
    // MARK: - Initializers
    init(
        profileService: ProfileServiceProtocol = ProfileService.shared,
        profileImageService: ProfileImageServiceProtocol = ProfileImageService.shared,
        profileLogoutService: ProfileLogoutServiceProtocol = ProfileLogoutService.shared,
    ) {
        self.profileService = profileService
        self.profileImageService = profileImageService
        self.profileLogoutService = profileLogoutService
    }
    
    // MARK: - Public Methods
    func viewDidLoad() {
        if let profile = profileService?.profile {
            view?.setupView(
                userName: profile.name.isEmpty ? "Имя не указано" : profile.name,
                userNickname: profile.loginName.isEmpty ? "@неизвестный_пользователь" : profile.loginName,
                userAbout: ((profile.bio?.isEmpty ?? true) ? "Профиль не заполнен" : profile.bio) ?? "Профиль не заполнен"
            )
        }
        
        profileImageServiceObserver = NotificationCenter.default
            .addObserver(
                forName: ProfileImageService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                self.updateAvatar()
            }
        updateAvatar()
    }
    
    func didTapLogoutButton() {
        let alertController = UIAlertController(
            title: "Пока, пока!",
            message: "Уверены, что хотите выйти?",
            preferredStyle: .alert
        )
        let yesAction = UIAlertAction(title: "Да", style: .default) { _ in
            self.profileLogoutService?.logout()
        }
        let noAction = UIAlertAction(title: "Нет", style: .default, handler: nil)
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        view?.showLogoutAlert(alertController: alertController)
    }
    
    // MARK: - Private Methods
    private func updateAvatar() {
        guard
            let profileImageURL = profileImageService?.avatarURL,
            let imageUrl = URL(string: profileImageURL)
        else { return }
        
        view?.setupAvatar(imageUrl)
    }
}
