//
//  MainView.swift
//  ReqResVIP
//
//  Created by user on 02/12/22.
//

import UIKit

protocol LoginViewProtocol: ViewCodeProtocol {
    func addActionInButtonLogin(in target: Any?, selector: Selector)
    func setupTextFieldDelegate(_ delegate: UITextFieldDelegate)
    func verifyField()
    func validateFields() -> Bool
    
    var nameTextField: UITextField { get set }
    var passwordTextField: UITextField { get set }
    var buttonLogin: UIButton { get set }
}

class LoginView: UIView, LoginViewProtocol {
    
    // MARK: - Components
    private(set) lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nome"
        return label
    }()
    
    private(set) lazy var passwordLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Senhas"
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        var field = UITextField()
        field.borderStyle = .bezel
        field.text = "eve.holt@reqres.in"
        field.clipsToBounds = true
        field.layer.cornerRadius = 7
        return field
    }()
    
    lazy var passwordTextField: UITextField = {
        var field = UITextField()
        field.borderStyle = .line
        field.text = "citysli"
        return field
    }()
    
    lazy var buttonLogin: UIButton = {
        var button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private(set) lazy var loginStack: UIStackView = {
        var stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 9
        return stack
    }()
    
    // MARK: - ViewCodeProtocol
    func buildViewHierachy() {
        addSubview(loginStack)
        
        loginStack.addArrangedSubview(nameLabel)
        loginStack.addArrangedSubview(nameTextField)
        loginStack.addArrangedSubview(passwordLabel)
        loginStack.addArrangedSubview(passwordTextField)
        loginStack.addArrangedSubview(buttonLogin)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            loginStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            loginStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 9),
            loginStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -9)
        ])
    }
    
    func addictionalConfiguration() {
        backgroundColor = .white
    }
    
    // MARK: - public fuctions
    func addActionInButtonLogin(in target: Any?, selector: Selector) {
        buttonLogin.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    func setupTextFieldDelegate(_ delegate: UITextFieldDelegate) {
        nameTextField.delegate = delegate
        passwordTextField.delegate = delegate
    }
    
    func verifyField() {
        if !nameTextField.isValid() {
            updateField(field: nameTextField)
        }
        if !passwordTextField.isValid() {
            updateField(field: passwordTextField)
        }
    }
    
    func validateFields() -> Bool {
        guard nameTextField.isValid(),
              passwordTextField.isValid() else {
            return false
        }
        return true
    }
    
    private func updateField(field: UITextField) {
        field.layer.borderColor = UIColor.red.cgColor
        field.layer.borderWidth = 1
        field.placeholder = "Preencher campo"
    }
}
