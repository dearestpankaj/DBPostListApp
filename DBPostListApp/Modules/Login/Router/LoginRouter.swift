//
//  LoginRouter.swift
//  DBPostListApp
//
//  Created by Pankaj Sachdeva on 10/09/23.
//

import UIKit

class LoginRouter: LoginPresenterToRouterProtocol {
    
    func createModule() -> LoginViewController {
        let loginViewModel = LoginViewModel()
        let presenter = LoginPresenter(router: LoginRouter(), viewModel: loginViewModel)
        return LoginViewController(presenter: presenter, viewModel: loginViewModel)
    }
    
    func pushToPostListScreen(userID: Int, navigationConroller navigationController: UINavigationController?) {
        let router = PostListRouter()
        let postListModule = router.createPostsListModule(userID)
        navigationController?.pushViewController(postListModule, animated: true)
    }
}
