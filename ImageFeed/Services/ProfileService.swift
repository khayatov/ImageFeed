//
//  ProfileService.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 23.12.25.
//

import Foundation

final class ProfileService {
    // MARK: - Public Properties
    static let shared = ProfileService()
    
    // MARK: - Private Properties
    private var lastTask: URLSessionTask?
    private let urlSession = URLSession.shared
    private(set) var profile: Profile?
    
    // MARK: - Initializers
    private init() {}
    
    // MARK: - Public Methods
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        let fulfillCompletionOnTheMainThread: (Result<Profile, Error>) -> Void = { result in
            DispatchQueue.main.async { [self] in
                completion(result)
                
                lastTask = nil
                
                switch result {
                case .success(let profile):
                    self.profile = profile
                case .failure(let error):
                    print("[fetchProfile]: Ошибка: \(error.localizedDescription)")
                    self.profile = nil
                }
            }
        }
        
        assert(Thread.isMainThread)
        lastTask?.cancel()
        
        guard let request = makeProfileRequest(token: token) else {
            print("[fetchProfile]: Ошибка получения request")
            fulfillCompletionOnTheMainThread(.failure(URLError(.badURL)))
            return
        }
        
        let task = urlSession.objectTask(for: request) { (result: Result<ProfileResult, Error>) in
            switch result {
            case .success(let data):
                let profile = Profile(
                    username: data.username,
                    name: "\(data.firstName) \(data.lastName)",
                    loginName: "@\(data.username)",
                    bio: data.bio
                )
                fulfillCompletionOnTheMainThread(.success(profile))
                
            case .failure(let error):
                print("[fetchProfile]: Ошибка запроса: \(error.localizedDescription)")
                fulfillCompletionOnTheMainThread(.failure(error))
            }
        }
        
        lastTask = task
        task.resume()
    }
    
    // MARK: - Private Methods
    private func makeProfileRequest(token: String) -> URLRequest? {
        guard let url = URL(string: "\(Constants.defaultBaseURL)/me") else {
            print("[makeProfileRequest]: Ошибка инициализации URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}

