//
//  AuthViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 09.01.26.
//

import Foundation

protocol AuthViewControllerDelegate: AnyObject {
    func didAuthenticate(_ vc: AuthViewController)
}
