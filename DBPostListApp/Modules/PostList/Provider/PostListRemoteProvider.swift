//
//  PostListRemoteProvider.swift
//  DBPostListApp
//
//  Created by Pankaj Sachdeva on 12/09/23.
//

import Foundation
import Combine
import Alamofire

class PostListRemoteProvider: PostListInteractorToRemoteProviderProtocol {
    
    func getUserPosts(userID: String) -> AnyPublisher<[PostDTO], NetworkErrors> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(userID)")
                return AF.request(url!,method: .get)
                             .publishDecodable(type: [PostDTO].self)
                             .value()
                             .mapError { _ in NetworkErrors.decoderError }
                             .eraseToAnyPublisher()
    }
}

enum NetworkErrors: Error{
    case urlError
    case responseError
    case decoderError
    case unknownError
}
