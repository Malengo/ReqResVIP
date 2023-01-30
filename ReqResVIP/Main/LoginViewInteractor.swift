//
//  MainViewInteractor.swift
//  ReqResVIP
//
//  Created by user on 02/12/22.
//

import UIKit

protocol LoginViewBusinessLogic {
    func authenticateUser(user: LoadUser.Request)
}

protocol LoginViewDataStore {
    var user: User { get set }
}

class LoginViewInteractor: LoginViewBusinessLogic {
    
    var authWorker: LoginAuthLogic = LoginAuthWorker()
    let presenter: LoginViewDisplayLogic?
    
    init(presenter: LoginViewDisplayLogic?) {
        self.presenter = presenter
    }
    
    func authenticateUser(user: LoadUser.Request) {
        authWorker.makeAuth(user: user) { result  in
            switch result {
            case .success( _):
                self.presenter?.successAuth()
            case .failure(let error):
                self.presenter?.failureAuth(error: error)
            }
        }
    }
}
