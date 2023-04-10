//
//  LoginViewInteractorTests.swift
//  ReqResVIPTests
//
//  Created by Jose Augusto on 27/01/23.
//

import Foundation
@testable import ReqResVIP

class LoginViewInteractorMock: LoginViewBusinessLogic {
    var wasAuthenticateUserCalled = false
    func authenticateUser(request: ReqResVIP.LoginUser.Request) {
       wasAuthenticateUserCalled = true
    }
    
    func authenticateWithBiometrics() {
        
    }
    
  
}
