//
//  PostListInteractor.swift
//  DBPostListApp
//
//  Created by Pankaj Sachdeva on 11/09/23.
//

import Foundation
import Combine

class PostListInteractor: PostListPresenterToInteractorProtocol {
    private let postListRemoteProvider: PostListInteractorToRemoteProviderProtocol
    private let postListLocalProvider: PostListInteractorToLocalProviderProtocol
    
    init(
        postListRemoteProvider: PostListInteractorToRemoteProviderProtocol,
        postListLocalProvider: PostListInteractorToLocalProviderProtocol
    ) {
        self.postListRemoteProvider = postListRemoteProvider
        self.postListLocalProvider = postListLocalProvider
    }
    
    func getUserPosts(userID: Int) -> AnyPublisher<[Post]?, NetworkError> {
        postListRemoteProvider.getUserPosts(userID: String(userID)).tryMap { [weak self] postDtoArray in
            if postDtoArray.count == 0 {
                throw NetworkError.noPostFound
            }
            let posts = postDtoArray.map {
                PostModel(userID: userID, postID: $0.id, title: $0.title, body: $0.body)
            }
            self?.postListLocalProvider.savePosts(posts: posts)
            return self?.postListLocalProvider.getUserPosts(userID: userID).map {
                Post(id: $0.postID, title: $0.title, detail: $0.body, isFavorite: $0.isFavorite)
            }
        }
        .mapError { $0 as! NetworkError }
        .eraseToAnyPublisher()
    }
    
    func getFavoritePosts(userID: Int) -> [Post] {
        postListLocalProvider.getFavoritePosts(userID: userID).map {
            Post(id: $0.postID , title: $0.title, detail: $0.body, isFavorite: $0.isFavorite)
        }
    }
    
    func setFavoritePost(_ post: Post) {
        postListLocalProvider.setFavoritePostStatus(postID: post.id, status: post.isFavorite)
    }
    
    func getPostsFromLocalDatasource(_ userID: Int) -> [Post] {
        postListLocalProvider.getUserPosts(userID: userID).map {
            Post(id: $0.postID, title: $0.title, detail: $0.body, isFavorite: $0.isFavorite)
        }
    }
}
