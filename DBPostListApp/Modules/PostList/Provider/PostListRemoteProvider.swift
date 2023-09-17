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
    
    let postsURL: String = "https://jsonplaceholder.typicode.com/posts?userId="
    
    func getUserPosts(userID: String) -> AnyPublisher<[PostDTO], NetworkError> {
        let url = URL(string: "\(postsURL)\(userID)")
                return AF.request(url!,method: .get)
                             .publishDecodable(type: [PostDTO].self)
                             .value()
                             .mapError { _ in NetworkError.decodeFailed }
                             .eraseToAnyPublisher()
    }
}
