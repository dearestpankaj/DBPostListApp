//
//  LoginViewController.swift
//  DBPostListApp
//
//  Created by Pankaj Sachdeva on 10/09/23.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    
    private let presenter: LoginViewToPresenterProtocol
    private let viewModel: LoginViewModel
    
    @IBOutlet var userIDTextField: UITextField?
    @IBOutlet var errorMessageLabel: UILabel?
    @IBOutlet var loginButton: UIButton?
    
    private var cancellable: AnyCancellable?
    
    init(
        presenter: LoginViewToPresenterProtocol,
        viewModel: LoginViewModel
    ) {
        self.presenter = presenter
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeBindings()
    }
    
    @IBAction private func loginTapped(_ sender: UIButton) {
        presenter.validateUserID(userID: userIDTextField?.text, navigationController: self.navigationController)
    }
    
    private func initializeBindings() {
        cancellable = viewModel.$errorMessage.sink(receiveValue: { [weak self] errorMessage in
            self?.errorMessageLabel?.text = errorMessage
        })
    }
}
