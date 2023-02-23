//
//  LoginAuthWorker.swift
//  ReqResVIP
//
//  Created by user on 03/12/22.
//

import Foundation

protocol LoginAuthLogic {
    func makeAuth(user: LoginUser.Request, completion: @escaping(Result<Bool, ResponseError>) -> Void)
}

class LoginAuthAPI: LoginAuthLogic {
    
    let loginUserDefauts = LoginUserDefaults.standard
    
    func makeAuth(user: LoginUser.Request, completion: @escaping (Result<Bool, ResponseError>) -> Void) {
        Task {
            do {
                try await requestApi(user: user)
                completion(.success(true))
            } catch let error {
                if error is DecodingError {
                    completion(.failure(.decodeError))
                }
                if let error = error as? ResponseError {
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func requestApi(user: LoginUser.Request) async throws {
        guard let url = URL(string: LoginConstants.Authenticator.urlPostRequest.rawValue) else { throw ResponseError.invalidUrl }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(user.user)
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else { throw ResponseError.invalidData }
            guard httpResponse.statusCode == 200 else { throw ResponseError.httpStatusCodeError(httpResponse.statusCode) }
            
            let token = try JSONDecoder().decode(Token.self, from: data)
            
            DispatchQueue.global(qos: .background).async {
                self.loginUserDefauts.saveToken(token.token)
            }
            
        } catch {
            throw ResponseError.invalidData
        }
    }
}
