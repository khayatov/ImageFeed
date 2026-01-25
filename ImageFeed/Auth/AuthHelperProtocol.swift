//
//  AuthHelperProtocol.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 23.01.26.
//

import Foundation

protocol AuthHelperProtocol {
    func authRequest() -> URLRequest?
    func code(from url: URL) -> String?
} 
