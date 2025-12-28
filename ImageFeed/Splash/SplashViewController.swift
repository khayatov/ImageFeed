//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 21.12.25.
//

import UIKit

final class SplashViewController: UIViewController {
    // MARK: - Private Properties
    private let showAuthenticationScreenSegueIdentifier = "ShowAuthenticationScreen"
    private let showImagesListScreenSegueIdentifier = "ShowImagesListScreen"
    private let oAuth2TokenStorage = OAuth2TokenStorage.shared
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    
    // MARK: - Overrides Methods
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let token = oAuth2TokenStorage.token {
            fetchProfile(token: token)
        } else {
            performSegue(withIdentifier: showAuthenticationScreenSegueIdentifier, sender: nil)
        }
    }
    
    // MARK: - Private Methods
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Invalid window configuration")
            return
        }
        
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarViewController")
        
        window.rootViewController = tabBarController
    }
    
    private func fetchProfile(token: String) {
        UIBlockingProgressHUD.show()
        
        profileService.fetchProfile(token) { [weak self] result in
            UIBlockingProgressHUD.dismiss()
            
            guard let self = self else { return }
            
            switch result {
            case .success(let profile):
                profileImageService.fetchProfileImageURL(username: profile.username, token: token) { _ in }
                
                self.switchToTabBarController()
            case .failure(let error):
                print("[fetchProfile]: Error: \(error)")
            }
        }
        
    }
}

extension SplashViewController {
    // MARK: - Overrides Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showAuthenticationScreenSegueIdentifier {
            guard
                let navigationController = segue.destination as? UINavigationController,
                let viewController = navigationController.viewControllers.first as? AuthViewController
            else {
                assertionFailure("Failed to prepare for \(showAuthenticationScreenSegueIdentifier)")
                return
            }
            
            viewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}

extension SplashViewController: AuthViewControllerDelegate {
    // MARK: - Public Methods
    func didAuthenticate(_ vc: AuthViewController) {
        vc.dismiss(animated: true)
        
        guard let token = oAuth2TokenStorage.token else {
            return
        }
        
        fetchProfile(token: token)
    }
}
