//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 29.12.25.
//

import Foundation
internal import CoreGraphics

final class ImagesListService {
    // MARK: - Public Properties
    static let shared = ImagesListService()
    static let didChangeNotification = Notification.Name("ImagesListServiceDidChange")
    
    // MARK: - Private Properties
    private(set) var photos: [Photo] = []
    private var lastLoadedPage = 0
    private var lastTask: URLSessionTask?
    private let urlSession = URLSession.shared
    private let oAuth2TokenStorage = OAuth2TokenStorage.shared
    private let dateFormatter = ISO8601DateFormatter()
    
    // MARK: - Initializers
    private init() {}
    
    // MARK: - Public Methods
    func fetchPhotosNextPage() {
        assert(Thread.isMainThread)
        lastTask?.cancel()
        
        guard let token = oAuth2TokenStorage.token else {
            print("[fetchPhotosNextPage]: Ошибка получения token")
            return
        }
        
        guard let request = makeImagesListRequest(token: token) else {
            print("[fetchPhotosNextPage]: Ошибка получения request")
            return
        }
        
        let task = urlSession.objectTask(for: request) { (result: Result<[PhotoResult], Error>) in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let data):
                    for photo in data {
                        photos.append(Photo.init(
                            id: photo.id,
                            size: CGSize(width: photo.width, height: photo.height),
                            createdAt: dateFormatter.date(from: photo.createdAt),
                            welcomeDescription: nil,
                            thumbImageURL: photo.urls.thumb,
                            largeImageURL: photo.urls.full,
                            isLiked: photo.likedByUser
                        ))
                    }
                    
                    lastLoadedPage += 1
                    
                    NotificationCenter.default.post(
                        name: ImagesListService.didChangeNotification,
                        object: self,
                        userInfo: ["Images": photos]
                    )
                    
                case .failure(let error):
                    print("[fetchPhotosNextPage]: Ошибка запроса: \(error.localizedDescription)")
                }
                
                lastTask = nil
            }
        }
        
        lastTask = task
        task.resume()
    }
    
    func changeLike(photoId: String, isLike: Bool, _ completion: @escaping (Result<Data, Error>) -> Void) {
        assert(Thread.isMainThread)
        lastTask?.cancel()
        
        guard let token = oAuth2TokenStorage.token else {
            print("[changeLike]: Ошибка получения token")
            return
        }
        
        guard let request = makeLikePhotoRequest(token: token, photoId: photoId, isLike: isLike) else {
            print("[changeLike]: Ошибка получения request")
            return
        }
        
        let task = urlSession.data(for: request) { (result: Result<Data, Error>) in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success:
                    if let index = self.photos.firstIndex(where: { $0.id == photoId }) {
                        let photo = self.photos[index]
                        photos[index] = Photo(
                            id: photo.id,
                            size: photo.size,
                            createdAt: photo.createdAt,
                            welcomeDescription: photo.welcomeDescription,
                            thumbImageURL: photo.thumbImageURL,
                            largeImageURL: photo.largeImageURL,
                            isLiked: !photo.isLiked
                        )
                    }
                    
                case .failure(let error):
                    print("[changeLike]: Ошибка запроса: \(error.localizedDescription)")
                }
                
                completion(result)
                lastTask = nil
            }
        }
        
        lastTask = task
        task.resume()
    }
    
    func cleanData() {
        lastTask?.cancel()
        lastTask = nil
        photos = [];
        lastLoadedPage = 0;
    }
    
    // MARK: - Private Methods
    private func makeImagesListRequest(token: String) -> URLRequest? {
        guard let url = URL(string: "\(Constants.defaultBaseURL)/photos/?page=\(lastLoadedPage + 1)&per_page=10") else {
            print("[makeImagesListRequest]: Ошибка инициализации URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    private func makeLikePhotoRequest(token: String, photoId: String, isLike: Bool) -> URLRequest? {
        guard let url = URL(string: "\(Constants.defaultBaseURL)/photos/\(photoId)/like") else {
            print("[makeLikePhotoRequest]: Ошибка инициализации URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = isLike ? HTTPMethod.post.rawValue : HTTPMethod.delete.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
