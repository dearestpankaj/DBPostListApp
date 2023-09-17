//
//  PostListProtocol.swift
//  DBPostListApp
//
//  Created by Pankaj Sachdeva on 11/09/23.
//

import UIKit
import Combine

protocol PostListPresenterToViewProtocol: AnyObject {
    func onPostListResponseSuccess()
    func onPostListResponseFailed(error: String)
}

protocol PostListViewToPresenterProtocol {
    func getUserPosts(userID: Int)
    func setPostView(postType index: Int)
    func setFavoritePost(post: Post)
}

protocol PostListPresenterToRouterProtocol {
    func createModule() -> PostListViewController
    func pushToPostListScreen(userID: String, navigationConroller navigationController: UINavigationController?)
}

protocol PostListPresenterToInteractorProtocol {
    func getUserPosts(userID: Int) -> AnyPublisher<[Post]?, NetworkErrors>
    func getfavoritePosts(userID: Int) -> [Post]
    func setFavoritePost(_ post: Post)
    func getPostsFromLocalDatasource(_ userID: Int) -> [Post]
}

protocol PostListInteractorToRemoteProviderProtocol {
    func getUserPosts(userID: String) -> AnyPublisher<[PostDTO], NetworkErrors>
}

protocol PostListInteractorToLocalProviderProtocol {
    func getUserPosts(userID: Int) -> [PostModel]
    func getFavoritePosts(userID: Int) -> [PostModel]
    func savePosts(userID: Int, posts: [Post])
    func setFavoritePostStatus(postID: Int, status: Bool)
}
