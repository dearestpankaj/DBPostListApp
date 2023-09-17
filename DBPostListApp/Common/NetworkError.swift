//
//  NetworkError.swift
//  DBPostListApp
//
//  Created by Pankaj Sachdeva on 17/09/23.
//

import Foundation

enum NetworkError: Error {
    // Throw when an invalid password is entered
    case decodeFailed

    // Throw when an expected resource is not found
    case noPostFound

    // Throw in all other cases
    case unexpected(code: Int)
}

extension NetworkError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .decodeFailed:
            return "Invalid response received."
        case .noPostFound:
            return "No post found for the user, please try again."
        case .unexpected(_):
            return "An unexpected error occurred."
        }
    }
}
