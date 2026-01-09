//
//  WebViewViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 09.01.26.
//

import Foundation

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewViewController)
}
