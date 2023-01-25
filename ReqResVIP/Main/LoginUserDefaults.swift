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
    func checkDateToken() -> Bool
}

class LoginUserDefaults: LoginUserDefaultsProtocol {
    
    // MARK: - Properties
    static var standard = LoginUserDefaults()
    private let userDefaults = UserDefaults.standard
    
    // MARK: - LoginUserDefaultsProtocol
    func saveToken(_ token: String) {
        userDefaults.set(token, forKey: LoginConstants.LoginUserDefaults.tokenKey.rawValue)
        saveDateToken()
    }
    
    func getToken() -> Bool {
        guard let _ = userDefaults.string(forKey: LoginConstants.LoginUserDefaults.tokenKey.rawValue) else { return false }
        return true
    }
    
    func checkDateToken() -> Bool {
        if let dateToken = userDefaults.object(forKey: LoginConstants.LoginUserDefaults.dateToken.rawValue) as? Date {
            let seconds = dateToken.timeIntervalSinceNow * -1
            if seconds > 300.0 {
                return false
            }
        }
        return true
    }

    // MARK: - private method
    private func saveDateToken() {
        userDefaults.set(Date(), forKey: LoginConstants.LoginUserDefaults.dateToken.rawValue)
    }
}
