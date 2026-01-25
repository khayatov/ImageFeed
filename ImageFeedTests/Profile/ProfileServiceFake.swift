//
//  ProfileServiceFake.swift
//  ImageFeedTests
//
//  Created by Andrey Khayatov on 25.01.26.
//

import ImageFeed
import Foundation

final class ProfileServiceFake: ProfileServiceProtocol {
    var profile: ImageFeed.Profile?
    
    func fetchProfile(_ token: String, completion: @escaping (Result<ImageFeed.Profile, Error>) -> Void) {}
    func cleanData() {}
}
