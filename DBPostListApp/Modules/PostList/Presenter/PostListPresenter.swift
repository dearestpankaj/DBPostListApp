//
//  PostListPresenter.swift
//  DBPostListApp
//
//  Created by Pankaj Sachdeva on 11/09/23.
//

import Foundation
import Combine


class PostListPresenter: PostListViewToPresenterProtocol {
    weak var view: PostListPresenterToViewProtocol?
    
    private let viewModel: PostListViewModel
    private let interactor: PostListPresenterToInteractorProtocol
    
    private var cancellable: AnyCancellable?
    
    init(
        view: PostListPresenterToViewProtocol? = nil,
        viewModel: PostListViewModel,
        interactor: PostListPresenterToInteractorProtocol
    ) {
        self.view = view
        self.viewModel = viewModel
        self.interactor = interactor
    }
    
    func getUserPosts(userID: Int) {
        viewModel.userID = userID
        cancellable = interactor.getUserPosts(userID: viewModel.userID).sink { [weak self] result in
            switch result {
            case .finished:
                print("success")
            case .failure(let error):
                self?.view?.onPostListResponseFailed(error: error.localizedDescription)
            }
        } receiveValue: { [weak self] posts in
            guard let posts = posts else {
                self?.view?.onPostListResponseFailed(error: "")
                return
            }
            self?.viewModel.posts = posts
            self?.view?.onPostListResponseSuccess()
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
            viewModel.posts = interactor.getfavoritePosts(userID: viewModel.userID)
        }
        view?.onPostListResponseSuccess()
    }
    
    func setFavoritePost(post: Post) {
        interactor.setFavoritePost(post)
        if case .favorite = viewModel.selectedViewType {
            viewModel.posts = interactor.getfavoritePosts(userID: viewModel.userID)
        } else {
            viewModel.posts = interactor.getPostsFromLocalDatasource(viewModel.userID)
        }
        view?.onPostListResponseSuccess()
    }
}
