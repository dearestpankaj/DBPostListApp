//
//  LoginPresenter.swift
//  DBPostListApp
//
//  Created by Pankaj Sachdeva on 10/09/23.
//

import UIKit

class LoginPresenter: LoginViewToPresenterProtocol {
    var router: PresenterToRouterProtocol?
    
    init(router: PresenterToRouterProtocol? = nil) {
        self.router = router
    }
    
    func validateUserID(userID: String?, navigationController: UINavigationController?) {
        guard let userID = userID, !userID.isEmpty else {
            showError()
            return
        }
        router?.pushToPostListScreen(userID: userID, navigationConroller: navigationController)
    }
    
    func showError() {
        
    }
}
