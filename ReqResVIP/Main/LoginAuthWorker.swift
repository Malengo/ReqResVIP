//
//  LoginAuthWorker.swift
//  ReqResVIP
//
//  Created by user on 03/12/22.
//

import Foundation

protocol LoginAuthLogic {
    func makeAuth(user: LoadUser.Request, completion: @escaping(Result<Bool, ResponseError>) -> Void)
}

class LoginAuthWorker: LoginAuthLogic {
    
    let loginUserDefauts = LoginUserDefaults()
    
    func makeAuth(user: LoadUser.Request, completion: @escaping (Result<Bool, ResponseError>) -> Void) {
        Task {
            do {
                try await requestApi(user: user) { result in
                    if result {
                        completion(.success(true))
                    } else {
                        completion(.failure(.invalidData))
                    }
                }
            } catch {
                completion(.failure(.invalidData))
            }
        }
    }
    
    private func requestApi(user: LoadUser.Request, completion: @escaping(Bool) -> ()) async throws {
        guard let url = URL(string: LoginConstants.Authenticator.urlPostRequest.rawValue) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(user.user)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            completion(false)
            return
        }
        
        let token = try JSONDecoder().decode(Token.self, from: data)
        
        DispatchQueue.global(qos: .background).async {
            self.loginUserDefauts.saveToken(token.token)
        }
        completion(true)
    }
}
