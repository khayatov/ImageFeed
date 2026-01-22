//
//  NetworkError.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 22.01.26.
//

import Foundation

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
    case invalidRequest
    case decodingError(Error)
}
