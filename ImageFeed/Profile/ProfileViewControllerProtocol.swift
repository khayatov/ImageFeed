//
//  ProfileViewControllerProtocol.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 25.01.26.
//

import Foundation
import UIKit

public protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }
    
    func configure(_ presenter: ProfilePresenterProtocol)
    func setupView(userName: String, userNickname: String, userAbout: String)
    func setupAvatar(_ imageUrl: URL)
    func showLogoutAlert(alertController: UIAlertController)
}
