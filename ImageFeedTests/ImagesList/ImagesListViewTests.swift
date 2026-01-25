//
//  ImagesListViewTests.swift
//  ImageFeedTests
//
//  Created by Andrey Khayatov on 25.01.26.
//

@testable import ImageFeed
import XCTest

@MainActor
final class ImagesListViewTests: XCTestCase {
    
    func testViewControllerCallsViewDidLoad() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController") as! ImagesListViewController
        let presenter = ImagesListPresenterSpy()
        viewController.configure(presenter)
        
        _ = viewController.view
        
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testPresenterCallsFetchPhotosNextPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController") as! ImagesListViewController
        
        let imageListService = ImageListServiceSpy()
        let presenter = ImagesListPresenter(imagesListService: imageListService)
        viewController.configure(presenter)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(imageListService.fetchPhotosNextPageCalled)
    }
    
    func testGetCountPhotos() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController") as! ImagesListViewController
        
        let imageListService = ImageListServiceSpy()
        for i in 1...3 {
            imageListService.photos.append(Photo.init(
                id: "\(i)",
                size: CGSize(width: 1, height: 1),
                createdAt: nil,
                welcomeDescription: nil,
                thumbImageURL: "",
                largeImageURL: "",
                isLiked: false
            ))
        }
        
        let presenter = ImagesListPresenter(imagesListService: imageListService)
        viewController.configure(presenter)
        
        _ = viewController.view
        
        XCTAssertEqual(presenter.getCountPhotos(), 3)
    }
    
    func testGetCellHeight() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController") as! ImagesListViewController
        
        let imageListService = ImageListServiceSpy()
        for i in 1...3 {
            imageListService.photos.append(Photo.init(
                id: "\(i)",
                size: CGSize(width: i, height: i),
                createdAt: nil,
                welcomeDescription: nil,
                thumbImageURL: "",
                largeImageURL: "",
                isLiked: false
            ))
        }
        
        let presenter = ImagesListPresenter(imagesListService: imageListService)
        viewController.configure(presenter)
        
        _ = viewController.view
        
        XCTAssertEqual(presenter.getCellHeight(tableView: UITableView(), indexPhoto: 1), -24.0)
    }
    
    func testPresenterChangeLikeCallsChangeLike() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController") as! ImagesListViewController
        
        let imageListService = ImageListServiceSpy()
        for i in 1...3 {
            imageListService.photos.append(Photo.init(
                id: "\(i)",
                size: CGSize(width: i, height: i),
                createdAt: nil,
                welcomeDescription: nil,
                thumbImageURL: "",
                largeImageURL: "",
                isLiked: false
            ))
        }
        
        let presenter = ImagesListPresenter(imagesListService: imageListService)
        viewController.configure(presenter)
        
        _ = viewController.view
        
        presenter.changeLike(1) { isLiked in
            XCTAssertEqual(isLiked, true)
            XCTAssertTrue(imageListService.changeLikeCalled)
        }
    }
}

