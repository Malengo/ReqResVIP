//
//  LoginViewPresenter.swift
//  ReqResVIP
//
//  Created by Jose Augusto on 20/02/23.
//

import Foundation
import LocalAuthentication

protocol LoginViewPresenterProtocol {
    func successAuth()
    func failureAuth(error: ResponseError)
}

class LoginViewPresenter: LoginViewPresenterProtocol {
    
    var view: LoginViewDisplayLogic?
    
    init(view: LoginViewDisplayLogic) {
        self.view = view
    }

    func successAuth() {
        view?.successAuth()
    }
    
    func failureAuth(error: ResponseError) {
        view?.failureAuth(error.description)
    }
}
