//
//  AuthConfiguration.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 20.12.25.
//

import Foundation

struct AuthConfiguration {
    let accessKey: String
    let secretKey: String
    let redirectURI: String
    let accessScope: String
    let defaultBaseURLString: String
    let authURLString: String
    
    static var standard: AuthConfiguration {
        AuthConfiguration(accessKey: Constants.accessKey,
                          secretKey: Constants.secretKey,
                          redirectURI: Constants.redirectURI,
                          accessScope: Constants.accessScope,
                          defaultBaseURLString: Constants.defaultBaseURLString,
                          authURLString: Constants.unsplashAuthorizeURLString)
    }
}
