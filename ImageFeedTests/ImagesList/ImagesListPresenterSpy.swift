//
//  ImagesListPresenterSpy.swift
//  ImageFeedTests
//
//  Created by Andrey Khayatov on 25.01.26.
//

import ImageFeed
import Foundation
import UIKit

final class ImagesListPresenterSpy: ImagesListPresenterProtocol {
    var view: ImagesListViewControllerProtocol?
    var viewDidLoadCalled: Bool = false
    private var photos: [Photo] = []
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func prepareSingleImage(for segue: UIStoryboardSegue, sender: Any?) {}
    
    func getCountPhotos() -> Int {
        1
    }
    
    func getPhoto(_ index: Int) -> ImageFeed.Photo {
        photos[index]
    }
    
    func getCellHeight(tableView: UITableView, indexPhoto: Int) -> CGFloat {
        0.1
    }
    
    func fetchPhotosNextPage(indexPath: IndexPath) {}
    
    func changeLike(_ indexPhoto: Int, completion: @escaping (Bool) -> Void) {}
}
