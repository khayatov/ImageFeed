//
//  ImageListServiceMock.swift
//  ImageFeedTests
//
//  Created by Andrey Khayatov on 25.01.26.
//

import ImageFeed
import Foundation

final class ImageListServiceSpy: ImagesListServiceProtocol {
    var photos: [Photo] = []
    var fetchPhotosNextPageCalled: Bool = false
    var changeLikeCalled: Bool = false
    
    func fetchPhotosNextPage() {
        fetchPhotosNextPageCalled = true
    }
    
    func changeLike(photoId: String, isLike: Bool, _ completion: @escaping (Result<Data, any Error>) -> Void) {
        changeLikeCalled = true
    }
    
    func cleanData() {}
}
