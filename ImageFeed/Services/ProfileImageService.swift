//
//  ProfileImageService.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 26.12.25.
//

import Foundation

struct ProfileImage: Codable {
    let small: String
    let medium: String
    let large: String
}

struct UserResult: Codable {
    let profileImage: ProfileImage
}

final class ProfileImageService {
    // MARK: - Public Properties
    static let shared = ProfileImageService()
    static let didChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")
    
    // MARK: - Private Properties
    private var lastTask: URLSessionTask?
    private let urlSession = URLSession.shared
    private(set) var avatarURL: String?
    
    // MARK: - Initializers
    private init() {}
    
    // MARK: - Public Methods
    func fetchProfileImageURL(username: String, token: String, completion: @escaping (Result<String, Error>) -> Void) {
        let fulfillCompletionOnTheMainThread: (Result<String, Error>) -> Void = { result in
            DispatchQueue.main.async { [self] in
                completion(result)
                
                lastTask = nil
                
                switch result {
                case .success(let profileImageURL):
                    self.avatarURL = profileImageURL
                    
                    NotificationCenter.default
                        .post(
                            name: ProfileImageService.didChangeNotification,
                            object: self,
                            userInfo: ["URL": profileImageURL])
                case .failure(let error):
                    print("[fetchProfileImageURL]: Ошибка: \(error.localizedDescription)")
                    self.avatarURL = nil
                }
            }
        }
        
        assert(Thread.isMainThread)
        lastTask?.cancel()
        
        guard let request = makeProfileImageRequest(username: username, token: token) else {
            print("[fetchProfileImageURL]: Ошибка получения request")
            fulfillCompletionOnTheMainThread(.failure(URLError(.badURL)))
            return
        }
        
        let task = urlSession.objectTask(for: request) { (result: Result<UserResult, Error>) in
            switch result {
            case .success(let data):
                fulfillCompletionOnTheMainThread(.success(data.profileImage.medium))
                
            case .failure(let error):
                print("[fetchProfileImageURL]: Ошибка запроса: \(error.localizedDescription)")
                fulfillCompletionOnTheMainThread(.failure(error))
            }
        }
        
        lastTask = task
        task.resume()
    }
    
    // MARK: - Private Methods
    private func makeProfileImageRequest(username: String, token: String) -> URLRequest? {
        guard let url = URL(string: "https://api.unsplash.com/users/\(username)") else {
            print("[makeProfileImageRequest]: Ошибка инициализации URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
