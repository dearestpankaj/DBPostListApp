//
//  LoginRouter.swift
//  DBPostListApp
//
//  Created by Pankaj Sachdeva on 10/09/23.
//

import UIKit

class LoginRouter: PresenterToRouterProtocol {
    
    func createModule() -> LoginViewController {
        let presenter = LoginPresenter(router: LoginRouter())
        return LoginViewController(presenter: presenter)
    }
    
    func pushToPostListScreen(userID: String, navigationConroller navigationController: UINavigationController?) {
        let router = PostListRouter()
        let postListModule = router.createPostsListModule()
        navigationController?.pushViewController(postListModule, animated: true)
    }
}
