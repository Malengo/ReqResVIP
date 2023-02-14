//
//  LoginAuthWorker.swift
//  ReqResVIP
//
//  Created by Jose Augusto on 13/02/23.
//

import Foundation

class LoginAuthWorker {
    
    var loginAuth: LoginAuthLogic
    
    init(loginAuth: LoginAuthLogic) {
        self.loginAuth = loginAuth
    }
    
    func makeAuth(user: LoadUser.Request, completion: @escaping (Result<Bool, ResponseError>) -> Void) {
        loginAuth.makeAuth(user: user) { result in
            completion(result)
        }
    }
}
