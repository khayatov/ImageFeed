//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 21.12.25.
//

import Foundation

final class OAuth2Service {
    // MARK: - Public Properties
    static let shared = OAuth2Service()
    
    // MARK: - Private Properties
    private enum ServiceError: Error {
        case codeError
        case invalidRequest
    }
    private let oAuth2TokenStorage = OAuth2TokenStorage()
    private let urlSession = URLSession.shared
    private var lastTask: URLSessionTask?
    private var lastCode: String?
    
    // MARK: - Initializers
    private init() {}
    
    // MARK: - Public Methods
    func fetchOAuthToken(code: String, completion: @escaping (Result<String, Error>) -> Void) {
        let fulfillCompletionOnTheMainThread: (Result<String, Error>) -> Void = { result in
            DispatchQueue.main.async { [self] in
                completion(result)
                
                lastTask = nil
                lastCode = nil
            }
        }
        
        assert(Thread.isMainThread)
        guard lastCode != code else {
            print("Ошибка: повторный запрос токена")
            fulfillCompletionOnTheMainThread(.failure(ServiceError.invalidRequest))
            return
        }
        lastTask?.cancel()
        lastCode = code
        
        guard let request = makeOAuthTokenRequest(code: code) else {
            print("Ошибка получения request")
            fulfillCompletionOnTheMainThread(.failure(ServiceError.codeError))
            return
        }
        
        let task = URLSession.shared.data(for: request) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(OAuthTokenResponseBody.self, from: data)
                    self.oAuth2TokenStorage.token = decodedData.accessToken
                    fulfillCompletionOnTheMainThread(.success(decodedData.accessToken))
                } catch {
                    print("Ошибка декодирования: \(error.localizedDescription)")
                    fulfillCompletionOnTheMainThread(.failure(error))
                }
            case .failure(let error):
                print("Ошибка запроса: \(error.localizedDescription)")
                fulfillCompletionOnTheMainThread(.failure(error))
            }
        }
        lastTask = task
        task.resume()
    }
    
    // MARK: - Private Methods
    private func makeOAuthTokenRequest(code: String) -> URLRequest? {
        guard var urlComponents = URLComponents(string: "https://unsplash.com/oauth/token") else {
            print("Ошибка инициализации URLComponents")
            return nil
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code"),
        ]
        
        guard let authTokenUrl = urlComponents.url else {
            print("Ошибка: URLComponents не сформировал url")
            return nil
        }
        
        var request = URLRequest(url: authTokenUrl)
        request.httpMethod = "POST"
        return request
    }
}
