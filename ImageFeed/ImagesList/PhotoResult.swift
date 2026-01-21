//
//  PhotoResult.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 11.01.26.
//

import Foundation

struct PhotoResult: Codable {
    let id: String
    let createdAt: String
    let likedByUser: Bool
    let width: Int
    let height: Int
    let urls: UrlsResult
}
