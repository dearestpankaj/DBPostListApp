//
//  PostListPresenterToInteractorMock.swift
//  DBPostListAppTests
//
//  Created by Pankaj Sachdeva on 17/09/23.
//

import Foundation
@testable import DBPostListApp
import Combine

class MockPostListPresenterToInteractor: PostListPresenterToInteractorProtocol {
    let posts: [Post]?
    var isSetFavPostCalled = false
    
    init(posts: [Post]?) {
        self.posts = posts
    }
    
    func getUserPosts(userID: Int) -> AnyPublisher<[Post]?, NetworkError> {
        Just(posts).setFailureType(to: NetworkError.self).eraseToAnyPublisher()
    }
    
    func getFavoritePosts(userID: Int) -> [Post] {
        [Post(id: 1, title: "title", detail: "post detail", isFavorite: true)]
    }
    
    func setFavoritePost(_ post: Post) {
        isSetFavPostCalled = true
    }
    
    func getPostsFromLocalDatasource(_ userID: Int) -> [Post] {
        [Post(id: 1, title: "title", detail: "post detail", isFavorite: true), Post(id: 2, title: "title", detail: "post detail", isFavorite: true)]
    }
    
    
}

extension MockPostListPresenterToInteractor {
    public func getIsSetFavoritePostCalled() -> Bool {
        isSetFavPostCalled
    }
}
