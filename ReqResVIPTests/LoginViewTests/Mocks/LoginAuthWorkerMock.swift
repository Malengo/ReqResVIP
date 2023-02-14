//
//  LoginAuthWorkerMock.swift
//  ReqResVIPTests
//
//  Created by Jose Augusto on 30/01/23.
//

import Foundation
@testable import ReqResVIP

class LoginAuthWorkerMock: LoginAuthWorker {
    
    var makeAuthCompletionHandler: ((_ user: LoadUser.Request, _ completion: @escaping (Result<Bool, ResponseError>) -> Void) -> Void)?
    
    
    override func makeAuth(user: ReqResVIP.LoadUser.Request, completion: @escaping (Result<Bool, ReqResVIP.ResponseError>) -> Void) {
        
        makeAuthCompletionHandler?(user, completion)
    }
    
    
}
