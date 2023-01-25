//
//  ViewController.swift
//  ReqResVIP
//
//  Created by user on 02/12/22.
//

import UIKit

protocol LoginViewDisplayLogic {
    func successAuth()
    func failureAuth(error: ResponseError)
}

class LoginViewController: UIViewController {
    
    lazy var mainView: LoginView = {
        let view = LoginView()
        return view
    }()
    
    // MARK: - VIP properties
    var interactor: LoginViewBusinessLogic?
    var router: LoginRoutingLogic?
    
    // MARK: - life Cyvle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        buttonAction()
    }
    
    override func loadView() {
        mainView.setupView()
        mainView.setupTextFieldDelegate(self)
        view = mainView
    }
    
    // MARK: - private methods
    private func setup() {
        let presenter = self
        self.interactor = LoginViewInteractor(presenter: presenter)
        self.router = LoginRouter(viewController: self)
    }
    
    private func buttonAction() {
        mainView.addActionInButtonLogin(in: self, selector: #selector(validateUser))
    }
    
    @objc
    private func validateUser() {
        guard mainView.nameTextfied.isValid(),
              mainView.passwordTextField.isValid() else { mainView.verifyField()
            return
        }
        
        guard let name = mainView.nameTextfied.text,
              let password = mainView.passwordTextField.text else { return }
        
        let user = LoadUser.Request(user: User(email: name, password: password))
        interactor?.authenticateUser(user: user) 
    }
}

extension LoginViewController: LoginViewDisplayLogic {
    
    func successAuth() {
        router?.routeToHomeView()
    }
    
    func failureAuth(error: ResponseError) {
        print(error.description)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.black.cgColor
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderColor = UIColor.black.cgColor
        return true
    }
}

