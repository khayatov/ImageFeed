//
//  ImagesListCellDelegate.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 20.01.26.
//

import Foundation

protocol ImagesListCellDelegate: AnyObject {
    func imageListCellDidTapLike(_ cell: ImagesListCell)
}
