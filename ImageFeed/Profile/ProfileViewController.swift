//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 17.12.25.
//

import UIKit
import Kingfisher

final class ProfileViewController: UIViewController {
    // MARK: - Private Properties
    private let profileService = ProfileService.shared
    private let profileLogoutService = ProfileLogoutService.shared
    private var profileImageServiceObserver: NSObjectProtocol?
    private let userImageView = UIImageView(image: UIImage(resource: .avatar))
    
    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let profile = profileService.profile {
            setupView(
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
    
    // MARK: - Private Methods
    @objc private func didTapLogoutButton(_ sender: Any) {
        showLogoutAlert()
    }
    
    private func showLogoutAlert() {
        let alertController = UIAlertController(
            title: "Пока, пока!",
            message: "Уверены, что хотите выйти?",
            preferredStyle: .alert
        )
        let yesAction = UIAlertAction(title: "Да", style: .default) { _ in
            self.profileLogoutService.logout()
        }
        let noAction = UIAlertAction(title: "Нет", style: .default, handler: nil)
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func updateAvatar() {
        guard
            let profileImageURL = ProfileImageService.shared.avatarURL,
            let imageUrl = URL(string: profileImageURL)
        else { return }
        
        let processor = RoundCornerImageProcessor(cornerRadius: 35)
        userImageView.kf.indicatorType = .activity
        userImageView.kf.setImage(
            with: imageUrl,
            placeholder: UIImage(resource: .avatar),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage,
                .forceRefresh
            ])
    }
    
    private func setupView(userName: String, userNickname: String, userAbout: String) {
        view.backgroundColor = UIColor.ypBlackIOS
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userImageView)
        
        let userNameLabel = UILabel()
        userNameLabel.text = userName
        userNameLabel.textColor = UIColor.ypWhiteIOS
        userNameLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userNameLabel)
        
        let userNicknameLabel = UILabel()
        userNicknameLabel.text = userNickname
        userNicknameLabel.textColor = UIColor.ypGrayIOS
        userNicknameLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        userNicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userNicknameLabel)
        
        let userAboutLabel = UILabel()
        userAboutLabel.text = userAbout
        userAboutLabel.textColor = UIColor.ypWhiteIOS
        userAboutLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        userAboutLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userAboutLabel)
        
        let logoutButton = UIButton(type: .custom);
        logoutButton.setImage(UIImage(resource: .exit), for: .normal)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
        view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            userImageView.widthAnchor.constraint(equalToConstant: 70),
            userImageView.heightAnchor.constraint(equalToConstant: 70),
            
            userNameLabel.leadingAnchor.constraint(equalTo: userImageView.leadingAnchor),
            userNameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 8),
            userNameLabel.heightAnchor.constraint(equalToConstant: 18),
            
            userNicknameLabel.leadingAnchor.constraint(equalTo: userImageView.leadingAnchor),
            userNicknameLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            userNicknameLabel.heightAnchor.constraint(equalToConstant: 18),
            
            userAboutLabel.leadingAnchor.constraint(equalTo: userImageView.leadingAnchor),
            userAboutLabel.topAnchor.constraint(equalTo: userNicknameLabel.bottomAnchor, constant: 8),
            userAboutLabel.heightAnchor.constraint(equalToConstant: 18),
            
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            logoutButton.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: 44),
            logoutButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}
