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

class LoginAuthAPI: LoginAuthLogic, RequestApiProtocol {
   
    typealias ResponseApi = Bool
    typealias RequestApi = LoginUser.Request
    var urlRequest: URL?
    var request: URLRequest?
    var data: Data?
    
    let loginUserDefauts = LoginUserDefaults.standard
    
    func makeAuth(user: LoginUser.Request, completion: @escaping (Result<Bool, ResponseError>) -> Void) {
        Task {
            do {
                try await callApi(request: user) { result in
                    completion(.success(result))
                }
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
    
    // MARK: - RequestApiProtocol
    func setupRequest(_ requestApi: LoginUser.Request) throws {
        var urlRequest = URLRequest(url: urlRequest!)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try JSONEncoder().encode(requestApi.user)
        request = urlRequest
    }
    
    func validUrl() throws {
        guard let url = Foundation.URL(string: LoginConstants.Authenticator.urlPostRequest.rawValue) else { throw ResponseError.invalidUrl }
        urlRequest = url
    }
    
    func getData(_ completion: (Bool) -> ()) async throws {
        do {
            let (data, response) = try await URLSession.shared.data(for: request!)
            
            guard let httpResponse = response as? HTTPURLResponse else { throw ResponseError.invalidData }
            guard httpResponse.statusCode == 200 else {
                throw ResponseError.httpStatusCodeError(httpResponse.statusCode)
            }
            
            let token = try JSONDecoder().decode(Token.self, from: data)
            completion(true)
            DispatchQueue.global(qos: .background).async {
                self.loginUserDefauts.saveToken(token.token)
            }
        }
    }
}
