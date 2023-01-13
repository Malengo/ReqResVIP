//
//  LoginUserDefaults.swift
//  ReqResVIP
//
//  Created by Jose Augusto on 10/01/23.
//

import Foundation

protocol LoginUserDefaultsProtocol {
    func saveToken(_ token: String)
    func getToken() -> Bool
}

class LoginUserDefaults: LoginUserDefaultsProtocol {
    
    static var standard = LoginUserDefaults()
    
    private let userDefaults = UserDefaults.standard
    
    func saveToken(_ token: String) {
        userDefaults.set(token, forKey: "Token")
    }
    
    func getToken() -> Bool {
        guard let _ = userDefaults.string(forKey: "Token") else { return false }
        return true
    }
}
