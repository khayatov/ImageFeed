//
//  AuthHelperProtocol.swift
//  ImageFeed
//
//  Created by Andrey Khayatov on 23.01.26.
//

import Foundation

protocol AuthHelperProtocol {
    func createAuthURLRequest() -> URLRequest?
    func getCode(from url: URL) -> String?
} 
