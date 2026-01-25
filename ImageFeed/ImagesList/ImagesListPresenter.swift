//
//  ImagesListPresenter.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 25.01.26.
//

import Foundation
import UIKit

final class ImagesListPresenter: ImagesListPresenterProtocol {
    // MARK: - Public Properties
    weak var view: ImagesListViewControllerProtocol?
    
    // MARK: - Private Properties
    private var imagesListServiceObserver: NSObjectProtocol?
    private let imagesListService: ImagesListServiceProtocol
    private var photos: [Photo] = []
    
    // MARK: - Initializers
    init(imagesListService: ImagesListServiceProtocol = ImagesListService.shared) {
        self.imagesListService = imagesListService
    }
    
    // MARK: - Public Methods
    func viewDidLoad() {
        photos = imagesListService.photos
        
        imagesListServiceObserver = NotificationCenter.default.addObserver(
            forName: ImagesListService.didChangeNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.updateTable()
        }
        imagesListService.fetchPhotosNextPage()
    }
    
    func prepareSingleImage(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let viewController = segue.destination as? SingleImageViewController,
            let indexPath = sender as? IndexPath
        else {
            assertionFailure("Invalid segue destination")
            return
        }
        
        guard let url = URL(string: photos[indexPath.row].largeImageURL) else {
            return
        }
        
        view?.showSingleImage(viewController: viewController, url: url)
    }
    
    func getCountPhotos() -> Int {
        photos.count
    }
    
    func getPhoto(_ index: Int) -> Photo {
        photos[index]
    }
    
    func getCellHeight(tableView: UITableView, indexPhoto: Int) -> CGFloat {
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = photos[indexPhoto].size.width
        let scale = imageViewWidth / imageWidth
        let cellHeight = photos[indexPhoto].size.height * scale + imageInsets.top + imageInsets.bottom
        
        return cellHeight
    }
    
    func fetchPhotosNextPage(indexPath: IndexPath) {
        if
            indexPath.row + 1 == imagesListService.photos.count,
            !ProcessInfo.processInfo.arguments.contains("TestsUI")
        {
            imagesListService.fetchPhotosNextPage()
        }
    }
    
    func changeLike(_ indexPhoto: Int, completion: @escaping (Bool) -> Void) {
        let photo = photos[indexPhoto]
        
        UIBlockingProgressHUD.show()
        
        imagesListService.changeLike(photoId: photo.id, isLike: !photo.isLiked) { result in
            switch result {
            case .success:
                self.photos = self.imagesListService.photos
                completion(self.photos[indexPhoto].isLiked)
            case .failure(let error):
                print("[imageListCellDidTapLike]: Ошибка: \(error.localizedDescription)")
            }
            
            UIBlockingProgressHUD.dismiss()
        }
    }
    
    // MARK: - Private Methods
    private func updateTable() {
        let oldCount = photos.count
        let newCount = imagesListService.photos.count
        photos = imagesListService.photos
        if oldCount != newCount {
            view?.updateTableViewAnimated(oldCount: oldCount, newCount: newCount)
        }
    }
}
