//
//  ProfileServiceProtocol.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 25.01.26.
//

import Foundation

public protocol ProfileServiceProtocol: AnyObject {
    var profile: Profile? { get }
    
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void)
    func cleanData()
}
