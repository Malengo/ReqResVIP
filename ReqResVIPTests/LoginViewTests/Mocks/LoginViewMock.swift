//
//  LoginViewMock.swift
//  ReqResVIPTests
//
//  Created by Jose Augusto on 06/02/23.
//

import UIKit
@testable import ReqResVIP

class LoginViewMock: UIView, LoginViewProtocol {
    
    var nameTextField: UITextField = UITextField()
    var passwordTextField: UITextField = UITextField()
    var buttonLogin: UIButton = UIButton()
    
    var wasAddActionButtonLoginCalled = false
    var wasSetupTextFieldDelegateCalled = false
    var wasVerifyFieldCalled = false
    var wasValidateFieldsCalled = false
    var wasBuildViewHierachyCalled = false
    var wasSetupConstraintsCalled = false
    var wasAddtionalConfigurationCalled = false
    
    var addActionInButtonLoginCompletionHandler: ( (_ target: Any?, _ selector: Selector) -> Void)?
    
    func addActionInButtonLogin(in target: Any?, selector: Selector) {
        wasAddActionButtonLoginCalled = true
        addActionInButtonLoginCompletionHandler?(target, selector)
    }
    
    func setupTextFieldDelegate(_ delegate: UITextFieldDelegate) {
        wasSetupTextFieldDelegateCalled = true
    }
    
    func verifyField() {
        wasVerifyFieldCalled = true
    }
    
    func validateFields() -> Bool {
        wasValidateFieldsCalled = true
        return (nameTextField.isValid() || passwordTextField.isValid())
    }
    
    func buildViewHierachy() {
        wasBuildViewHierachyCalled = true
    }
    
    func setupConstraints() {
        wasSetupConstraintsCalled = true
    }
    
    func addictionalConfiguration() {
        wasAddtionalConfigurationCalled = true
    }
    
    
}
