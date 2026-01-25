//
//  ImagesListViewControllerProtocol.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 25.01.26.
//

import Foundation

public protocol ImagesListViewControllerProtocol: AnyObject {
    var presenter: ImagesListPresenterProtocol? { get set }
    
    func configure(_ presenter: ImagesListPresenterProtocol)
    func updateTableViewAnimated(oldCount: Int, newCount: Int)
    func showSingleImage(viewController: SingleImageViewController, url: URL)
}
