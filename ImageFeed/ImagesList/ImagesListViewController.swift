//
//  ImagesListViewController.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 04.12.25.
//

import UIKit
import Kingfisher

final class ImagesListViewController: UIViewController, ImagesListViewControllerProtocol {
    // MARK: - IB Outlets
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Public Properties
    var presenter: ImagesListPresenterProtocol?
    
    // MARK: - Private Properties
    private let showSingleImageSegueIdentifier = "ShowSingleImage"
    private let formatter = DateFormatter()
    private lazy var dateFormatter: DateFormatter = {
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
    
    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        
        presenter?.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showSingleImageSegueIdentifier {
            presenter?.prepareSingleImage(for: segue, sender: sender)
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    // MARK: - Public Methods
    func configure(_ presenter: ImagesListPresenterProtocol) {
        self.presenter = presenter
        presenter.view = self
    }
    
    func updateTableViewAnimated(oldCount: Int, newCount: Int) {
        tableView.performBatchUpdates {
            let indexPaths = (oldCount..<newCount).map { i in
                IndexPath(row: i, section: 0)
            }
            tableView.insertRows(at: indexPaths, with: .automatic)
        } completion: { _ in }
    }
    
    func showSingleImage(viewController: SingleImageViewController, url: URL) {
        UIBlockingProgressHUD.show()
        KingfisherManager.shared.retrieveImage(with: url) { result in
            DispatchQueue.main.async {
                UIBlockingProgressHUD.dismiss()
                
                switch result {
                case .success(let data):
                    viewController.image = data.image
                case .failure(let error):
                    print("[prepare]: Ошибка: \(error.localizedDescription)")
                    return
                }
            }
        }
    }
}

extension ImagesListViewController: UITableViewDataSource {
    // MARK: - Public Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getCountPhotos() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        
        configCell(for: imageListCell, with: indexPath)
        
        return imageListCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.fetchPhotosNextPage(indexPath: indexPath)
    }
    
    // MARK: - Private Methods
    private func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        guard let photo = presenter?.getPhoto(indexPath.row) else {
            return
        }
        
        guard let imageUrl = URL(string: photo.thumbImageURL) else {
            return
        }
        
        cell.cellImage.kf.indicatorType = .activity
        cell.cellImage.kf.setImage(with: imageUrl, placeholder: UIImage(resource: .placeholder)) { _ in
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
            cell.cellImage.kf.indicatorType = .none
        }
        
        if let date = photo.createdAt {
            cell.dateLabel.text = dateFormatter.string(from: date)
        } else {
            cell.dateLabel.text = ""
        }
        
        cell.likeButton.setImage(
            photo.isLiked ? UIImage(resource: .likeActive) : UIImage(resource: .likeNoActive)
            , for: .normal
        )
        
        cell.delegate = self
    }
}

extension ImagesListViewController: UITableViewDelegate {
    // MARK: - Public Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        presenter?.getCellHeight(tableView: tableView, indexPhoto: indexPath.row) ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: showSingleImageSegueIdentifier, sender: indexPath)
    }
}

extension ImagesListViewController: ImagesListCellDelegate {
    // MARK: - Public Methods
    func imageListCellDidTapLike(_ cell: ImagesListCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        presenter?.changeLike(indexPath.row) { isLiked in
            cell.setIsLiked(isLiked)
        }
    }
}
