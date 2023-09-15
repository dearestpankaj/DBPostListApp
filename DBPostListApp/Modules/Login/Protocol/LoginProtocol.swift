//
//  protocols.swift
//  DBPostListApp
//
//  Created by Pankaj Sachdeva on 10/09/23.
//

import UIKit

protocol LoginViewToPresenterProtocol {
    func validateUserID(userID: String?, navigationController: UINavigationController?)
}

protocol LoginPresenterToRouterProtocol {
    func createModule() -> LoginViewController
    func pushToPostListScreen(userID: Int, navigationConroller navigationController: UINavigationController?)
}
