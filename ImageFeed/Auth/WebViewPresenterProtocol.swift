//
//  WebViewPresenterProtocol.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 23.01.26.
//

import Foundation

public protocol WebViewPresenterProtocol {
    var view: WebViewViewControllerProtocol? { get set }
    
    func viewDidLoad()
    func didUpdateProgressValue(_ newValue: Double)
    func code(from url: URL) -> String?
}
