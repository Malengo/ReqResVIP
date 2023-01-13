//
//  LoginConstants.swift
//  ReqResVIP
//
//  Created by Jose Augusto on 13/01/23.
//

import Foundation

struct LoginConstants {
    
    enum LoginUserDefaults: String {
        case tokenKey = "Login"
    }
    
    enum Authenticator: String {
        case urlPostRequest = "https://reqres.in/api/login/"
    }
}
