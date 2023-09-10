//
//  LoginViewController.swift
//  DBPostListApp
//
//  Created by Pankaj Sachdeva on 10/09/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    var presenter: LoginViewToPresenterProtocol?
    @IBOutlet var userIDTextField: UITextField?
    
    init(presenter: LoginViewToPresenterProtocol?) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        presenter?.validateUserID(userID: userIDTextField?.text, navigationController: self.navigationController)
    }
}
