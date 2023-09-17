//
//  MockPostListRemoteProvider.swift
//  DBPostListAppTests
//
//  Created by Pankaj Sachdeva on 18/09/23.
//

import Foundation
@testable import DBPostListApp
import Combine

class MockPostListRemoteProvider: PostListInteractorToRemoteProviderProtocol {
    let posts: [PostDTO]
    
    init(posts: [PostDTO]) {
        self.posts = posts
    }
    
    func getUserPosts(userID: String) -> AnyPublisher<[PostDTO], DBPostListApp.NetworkError> {
        Just(posts).setFailureType(to: NetworkError.self).eraseToAnyPublisher()
    }
    
    
}
