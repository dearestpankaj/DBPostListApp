//
//  LoginPresenter.swift
//  DBPostListApp
//
//  Created by Pankaj Sachdeva on 10/09/23.
//

import UIKit

class LoginPresenter: LoginViewToPresenterProtocol {
    var router: LoginPresenterToRouterProtocol?
    var viewModel: LoginViewModel
    
    init(
        router: LoginPresenterToRouterProtocol? = nil,
        viewModel: LoginViewModel
    ) {
        self.router = router
        self.viewModel = viewModel
    }
    
    func validateUserID(userID: String?, navigationController: UINavigationController?) {
        guard let userID = Int(userID ?? ""), userID > 0 else {
            showError(message: "Invalid user ID")
            return
        }
        router?.pushToPostListScreen(userID: userID, navigationConroller: navigationController)
    }
    
    func showError(message: String) {
        viewModel.errorMessage = message
    }
}
