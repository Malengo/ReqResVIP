//
//  MainView.swift
//  ReqResVIP
//
//  Created by user on 02/12/22.
//

import UIKit

class LoginView: UIView, ViewCodeProtocol {
    
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
    
    private(set) lazy var nameTextfied: UITextField = {
        var field = UITextField()
        field.borderStyle = .bezel
        field.text = "eve.holt@reqres.in"
        field.clipsToBounds = true
        field.layer.cornerRadius = 7
        return field
    }()
    
    private(set) lazy var passwordTextField: UITextField = {
        var field = UITextField()
        field.borderStyle = .line
        field.text = "cityslicka"
        return field
    }()
    
    private(set) lazy var buttonLogin: UIButton = {
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
        loginStack.addArrangedSubview(nameTextfied)
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
        nameTextfied.delegate = delegate
        passwordTextField.delegate = delegate
    }
    
    func verifyField() {
        if !nameTextfied.isValid() {
            updateField(field: nameTextfied)
        }
        if !passwordTextField.isValid() {
            updateField(field: passwordTextField)
        }
    }
    
    private func updateField(field: UITextField) {
        field.layer.borderColor = UIColor.red.cgColor
        field.layer.borderWidth = 1
        field.placeholder = "Preencher campo"
    }
}
