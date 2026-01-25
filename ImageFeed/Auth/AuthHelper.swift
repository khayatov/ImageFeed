//
//  AuthHelper.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 23.01.26.
//

import Foundation

final class AuthHelper: AuthHelperProtocol {
    // MARK: - Private Properties
    private let configuration: AuthConfiguration
    
    // MARK: - Initializers
    init(configuration: AuthConfiguration = .standard) {
        self.configuration = configuration
    }
    
    // MARK: - Public Methods
    func authRequest() -> URLRequest? {
        guard let url = authURL() else {
            print("[authRequest]: Ошибка: URLComponents не сформировал url")
            return nil
        }
        
        return URLRequest(url: url)
    }
    
    func authURL() -> URL? {
        guard var urlComponents = URLComponents(string: configuration.authURLString) else {
            print("[authURL]: Ошибка инициализации URLComponents")
            return nil
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: configuration.accessKey),
            URLQueryItem(name: "redirect_uri", value: configuration.redirectURI),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "scope", value: configuration.accessScope)
        ]
        
        return urlComponents.url
    }
    
    func code(from url: URL) -> String? {
        if let urlComponents = URLComponents(string: url.absoluteString),
           urlComponents.path == "/oauth/authorize/native",
           let items = urlComponents.queryItems,
           let codeItem = items.first(where: { $0.name == "code" })
        {
            return codeItem.value
        } else {
            return nil
        }
    }
}
