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
    
    func getUserPosts(userID: Int) -> AnyPublisher<[Post]?, NetworkErrors> {
        postListRemoteProvider.getUserPosts(userID: String(userID)).map { [weak self] postDtoArray in
            let posts = postDtoArray.map {
                Post(id: $0.id, title: $0.title, detail: $0.body, isFavorite: false)
            }
            self?.postListLocalProvider.savePosts(userID: userID, posts: posts)
            return self?.postListLocalProvider.getUserPosts(userID: userID).map {
                Post(id: $0.postID, title: $0.title, detail: $0.body, isFavorite: $0.isFavorite)
            }
        }.eraseToAnyPublisher()
    }
    
    func getfavoritePosts(userID: Int) -> [Post] {
        postListLocalProvider.getFavoritePosts(userID: userID).map {
            Post(id: $0.postID , title: $0.title, detail: $0.body, isFavorite: $0.isFavorite)
        }
    }
    
    func setFavoritePost(_ post: Post) {
        postListLocalProvider.setFavoritePostStatus(postID: post.id, status: post.isFavorite)
        let array = postListLocalProvider.getFavoritePosts(userID: 1)
    }
    
    func getPostsFromLocalDatasource(_ userID: Int) -> [Post] {
        postListLocalProvider.getUserPosts(userID: userID).map {
            Post(id: $0.postID, title: $0.title, detail: $0.body, isFavorite: $0.isFavorite)
        }
    }
}
