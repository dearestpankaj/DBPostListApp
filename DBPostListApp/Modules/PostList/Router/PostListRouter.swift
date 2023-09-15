//
//  PostListRouter.swift
//  DBPostListApp
//
//  Created by Pankaj Sachdeva on 10/09/23.
//

import Foundation

class PostListRouter {
    func createPostsListModule(_ userID: Int) -> PostListViewController {
        
        let viewModel = PostListViewModel()
        let provider = PostListRemoteProvider()
        let localProvider = PostListLocalProvider()
        let interactor = PostListInteractor(postListRemoteProvider: provider, postListLocalProvider: localProvider)
        let presenter = PostListPresenter(viewModel: viewModel, interactor: interactor)
        let view = PostListViewController(userID, viewModel, presenter)
        presenter.view = view
        
        return view
    }
}
