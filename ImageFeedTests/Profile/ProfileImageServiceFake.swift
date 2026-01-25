//
//  ProfileImageServiceFake.swift
//  ImageFeedTests
//
//  Created by Andrey Khayatov on 25.01.26.
//

import ImageFeed
import Foundation

final class ProfileImageServiceFake: ProfileImageServiceProtocol {
    var avatarURL: String?
    
    func fetchProfileImageURL(username: String, token: String, completion: @escaping (Result<String, Error>) -> Void) {}
    func cleanData() {}
}
