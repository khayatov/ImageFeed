//
//  ImagesListPresenterProtocol.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 25.01.26.
//

import Foundation
import UIKit

public protocol ImagesListPresenterProtocol: AnyObject {
    var view: ImagesListViewControllerProtocol? { get set }
    
    func viewDidLoad()
    func prepareSingleImage(for segue: UIStoryboardSegue, sender: Any?)
    func getCountPhotos() -> Int
    func getPhoto(_ index: Int) -> Photo
    func getCellHeight(tableView: UITableView, indexPhoto: Int) -> CGFloat
    func fetchPhotosNextPage(indexPath: IndexPath)
    func changeLike(_ indexPhoto: Int, completion: @escaping (Bool) -> Void)
}
