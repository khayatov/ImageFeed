//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 16.12.25.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    // MARK: - IB Outlets
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    
    // MARK - Public Properties
    static let reuseIdentifier = "ImagesListCell"
}
