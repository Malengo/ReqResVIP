//
//  LoginViewPresenterMock.swift
//  ReqResVIPTests
//
//  Created by Jose Augusto on 30/01/23.
//

import Foundation
@testable import ReqResVIP

class LoginViewPresenterMock: LoginViewPresenterProtocol {
    
    var wasSuccessAuthCalled: Bool = false
    var wasFailureAuthCalled: Bool = false
    
    func successAuth() {
        wasSuccessAuthCalled = true
    }
    
    func failureAuth(error: ReqResVIP.ResponseError) {
        wasFailureAuthCalled = true
    }   
}
