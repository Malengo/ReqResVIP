//
//  MainViewInteractor.swift
//  ReqResVIP
//
//  Created by user on 02/12/22.
//

import UIKit
import LocalAuthentication

protocol LoginViewBusinessLogic {
    func authenticateUser(request: LoginUser.Request)
    func authenticateWithBiometrics()
}

protocol LoginViewDataStore {
    var isPermissionBiometrics: Bool { get }
}

class LoginViewInteractor: LoginViewBusinessLogic, LoginViewDataStore {
    
    var authWorker = LoginAuthWorker(loginAuth: LoginAuthAPI())
    let presenter: LoginViewPresenterProtocol?
    var context = LAContext()
    
    var isPermissionBiometrics: Bool {
        get {
            var error: NSError?
            return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        }
    }
    
    init(presenter: LoginViewPresenterProtocol?) {
        self.presenter = presenter
    }
    
    func authenticateUser(request: LoginUser.Request) {
        authWorker.makeAuth(user: request) { [weak self] result  in
            switch result {
            case .success( _):
                self?.enableBiometrics()
                self?.presenter?.successAuth()
            case .failure(let error):
                self?.presenter?.failureAuth(error: error)
            }
        }
    }
    
    private func enableBiometrics() {
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Deseja sempre realizar login com a biometria") { [weak self] result , error in
            if result {
                self?.presenter?.successAuth()
            }
        }
    }
    
    func authenticateWithBiometrics() {
        if LoginUserDefaults.standard.checkDateToken() {
            if isPermissionBiometrics {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Deseja sempre realizar login com a biometria") { [weak self] result , error in
                    if result {
                        self?.presenter?.successAuth()
                    }
                }
            }
        }
    }
}
