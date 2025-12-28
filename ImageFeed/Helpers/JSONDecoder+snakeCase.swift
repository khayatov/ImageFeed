//
//  JSONDecoder+snakeCase.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 23.12.25.
//

import Foundation

extension JSONDecoder {
    static var snakeCase: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
