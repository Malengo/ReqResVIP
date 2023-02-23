//
//  MainViewInteractor.swift
//  ReqResVIP
//
//  Created by user on 02/12/22.
//

import UIKit

protocol LoginViewBusinessLogic {
    func authenticateUser(request: LoginUser.Request)
}

protocol LoginViewDataStore {
    var user: User { get set }
}

class LoginViewInteractor: LoginViewBusinessLogic {
    
    var authWorker = LoginAuthWorker(loginAuth: LoginAuthAPI())
    let presenter: LoginViewPresenterProtocol?
    
    init(presenter: LoginViewPresenterProtocol?) {
        self.presenter = presenter
    }
    
    func authenticateUser(request: LoginUser.Request) {
        authWorker.makeAuth(user: request) { result  in
            switch result {
            case .success( _):
                self.presenter?.successAuth()
            case .failure(let error):
                self.presenter?.failureAuth(error: error)
            }
        }
    }
}
