//
//  ProfileImageServiceProtocol.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 25.01.26.
//

import Foundation

public protocol ProfileImageServiceProtocol {
    var avatarURL: String? { get }
    func fetchProfileImageURL(username: String, token: String, completion: @escaping (Result<String, Error>) -> Void)
    func cleanData()
}
