//
//  ImagesListViewController.swift
//  ImageFeedTests
//
//  Created by Andrey Khayatov on 25.01.26.
//

import Foundation

import ImageFeed
import Foundation

final class ImagesListViewControllerSpy: ImagesListViewControllerProtocol {
    var presenter: ImagesListPresenterProtocol?
    var updateTableViewAnimatedCalled: Bool = false
    var showSingleImageCalled: Bool = false
    
    func configure(_ presenter: any ImageFeed.ImagesListPresenterProtocol) {
        self.presenter = presenter
        presenter.view = self
    }
    
    func updateTableViewAnimated(oldCount: Int, newCount: Int) {
        updateTableViewAnimatedCalled = true
    }
    
    func showSingleImage(viewController: ImageFeed.SingleImageViewController, url: URL) {
        showSingleImageCalled = true
    }
}
