//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 17.12.25.
//

import UIKit

final class ProfileViewController: UIViewController {
    @IBOutlet private var userPhotoImageView: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var userNiknameLabel: UILabel!
    @IBOutlet private var userAboutLabel: UILabel!
    @IBOutlet private var exitButton: UIButton!
    
    @IBAction private func touchUpInsideExitButton() {
    }
}
