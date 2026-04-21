//
//  WebViewViewControllerProtocol.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 23.01.26.
//

import Foundation

public protocol WebViewViewControllerProtocol: AnyObject {
    var presenter: WebViewPresenterProtocol? { get set }
    
    func load(request: URLRequest)
    func setProgressValue(_ newValue: Float)
    func setProgressHidden(_ isHidden: Bool)
}
