//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 18.12.25.
//

import UIKit

final class SingleImageViewController: UIViewController {
    @IBOutlet private var imageView: UIImageView!
    
    @IBAction func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
    
    var image: UIImage? {
            didSet {
                guard isViewLoaded else { return }
                imageView.image = image
            }
        }
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
            imageView.image = image
        }
}
