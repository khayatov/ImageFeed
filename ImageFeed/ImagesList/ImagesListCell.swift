//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 16.12.25.
//

import UIKit
import Kingfisher

final class ImagesListCell: UITableViewCell {
    // MARK: - IB Outlets
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dateLabel: UILabel!
    
    // MARK: - Public Properties
    weak var delegate: ImagesListCellDelegate?
    static let reuseIdentifier = "ImagesListCell"
    
    // MARK: - Overrides Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellImage.kf.cancelDownloadTask()
    }
    
    // MARK: - IB Actions
    @IBAction private func likeButtonClicked() {
        delegate?.imageListCellDidTapLike(self)
    }
    
    // MARK: - Public Methods
    func setIsLiked(_ isLiked: Bool) {
        likeButton.setImage(
            isLiked ? UIImage(resource: .likeActive) : UIImage(resource: .likeNoActive)
            , for: .normal
        )
    }
}
