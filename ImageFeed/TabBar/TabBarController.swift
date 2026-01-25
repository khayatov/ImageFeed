//
//  TabBarController.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 28.12.25.
//

import UIKit

final class TabBarController: UITabBarController {
    override func awakeFromNib() {
        super.awakeFromNib()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        guard let imagesListViewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController") as? ImagesListViewController else {
            return
        }
        let imagesListPresenter = ImagesListPresenter()
        imagesListViewController.configure(imagesListPresenter)
        
        let profileViewController = ProfileViewController()
        let profilePresenter = ProfilePresenter()
        profileViewController.configure(profilePresenter)
        
        profileViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(resource: .tabProfileActive),
            selectedImage: nil
        )
        self.viewControllers = [imagesListViewController, profileViewController]
    }
}
