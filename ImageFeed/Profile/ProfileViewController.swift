//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 17.12.25.
//

import UIKit

final class ProfileViewController: UIViewController {
    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputProfileView(
            userImage: UIImage(resource: .user),
            userName: "Екатерина Новикова",
            userNickname: "@ekaterina_nov",
            userAbout: "Hello, World!"
        )
    }
    
    // MARK: - Private Methods
    private func outputProfileView(userImage: UIImage, userName: String, userNickname: String, userAbout: String) {
        view.backgroundColor = UIColor.ypBlackIOS
        
        let userImageView = UIImageView(image: userImage)
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
        
        let exitButton = UIButton(type: .custom);
        exitButton.setImage(UIImage(resource: .exit), for: .normal)
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(exitButton)
        
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
            
            exitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            exitButton.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            exitButton.widthAnchor.constraint(equalToConstant: 44),
            exitButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}
