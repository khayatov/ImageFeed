//
//  ProfileResult.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 09.01.26.
//

import Foundation

struct ProfileResult: Codable {
    let username: String
    let firstName: String
    let lastName: String
    let bio: String?
}
