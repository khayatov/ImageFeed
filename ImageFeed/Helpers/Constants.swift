//
//  Constants.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 21.04.26.
//

import Foundation

enum Constants {
//    static let accessKey = "3GrzeVmOO_KRvb-J2bt-KdpAqF8aeL0Kw4E6tjMrTpQ"
    static let accessKey = "sr2xViN8crjQ7aNBYw9eyLzmIq6gdzbDIc6L4lSwp0w"
//    static let accessKey = "UwgNH-hJQNwk8Ll4efoX-w46EZnlh4OVsHApRfcWYXs"
    
//    static let secretKey = "AdDeISoJmnGJNO8wN2OfVJLi1J0-bZ7k3-qcC8LULG4"
    static let secretKey = "cILI0kUPp01sWAn4xUSP4Mnj47vVYoA-4xkWf0Wcxsc"
//    static let secretKey = "1hVjy9PVjtUWviYnTNNUo0efqiMJQMURdMmx_pgZQOA"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"
    static let defaultBaseURLString = "https://api.unsplash.com"
    static let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
    
    static let webViewSegueIdentifier = "ShowWebView"
    static let authWebViewIdentifier = "authWebView"
    static let logoutButtonIdentifier = "logoutButton"
    static let imagesListCellIdentifier = "ImagesListCell"
    static let showSingleImageSegueIdentifier = "ShowSingleImage"
    static let showAuthenticationScreenSegueIdentifier = "ShowAuthenticationScreen"
    static let showImagesListScreenSegueIdentifier = "ShowImagesListScreen"
    static let navigationViewControllerIdentifier = "NavigationViewController"
    static let tabBarViewControllerIdentifier = "TabBarViewController"
    static let imagesListViewControllerIdentifier = "ImagesListViewController"
    static let webViewViewControllerIdentifier = "WebViewViewController"
}
