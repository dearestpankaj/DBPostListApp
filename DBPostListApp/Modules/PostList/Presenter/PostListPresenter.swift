//
//  PostListPresenter.swift
//  DBPostListApp
//
//  Created by Pankaj Sachdeva on 11/09/23.
//

import Foundation
import Combine


class PostListPresenter: PostListViewToPresenterProtocol {
    
    private let viewModel: PostListViewModel
    private let interactor: PostListPresenterToInteractorProtocol
    
    private var cancellable: AnyCancellable?
    
    init(
        viewModel: PostListViewModel,
        interactor: PostListPresenterToInteractorProtocol
    ) {
        self.viewModel = viewModel
        self.interactor = interactor
    }
    
    func getUserPosts(userID: Int) {
        viewModel.userID = userID
        viewModel.isLoading = true
        
        cancellable = interactor.getUserPosts(userID: viewModel.userID).sink { [weak self] result in
            self?.viewModel.isLoading = false
            switch result {
            case .failure(let error):
                self?.viewModel.errorMessage = error.description
            default:
                break
            }
        } receiveValue: { [weak self] posts in
            guard let posts = posts else {
                self?.viewModel.errorMessage = "Posts not found for the user"
                return
            }
            self?.viewModel.posts = posts
        }
    }
    
    func setPostView(postType index: Int) {
        guard let postViewType = PostViewType(rawValue: index) else {
            return
        }
        viewModel.selectedViewType = postViewType
        
        switch viewModel.selectedViewType {
        case .all:
            viewModel.posts = interactor.getPostsFromLocalDatasource(viewModel.userID)
        case .favorite:
            viewModel.posts = interactor.getFavoritePosts(userID: viewModel.userID)
        }
    }
    
    func setFavoritePost(post: Post) {
        interactor.setFavoritePost(post)
        if case .favorite = viewModel.selectedViewType {
            viewModel.posts = interactor.getFavoritePosts(userID: viewModel.userID)
        } else {
            viewModel.posts = interactor.getPostsFromLocalDatasource(viewModel.userID)
        }
    }
}
