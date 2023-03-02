//
//  HomeViewWorker.swift
//  ReqResVIP
//
//  Created by Jose Augusto on 28/02/23.
//

import Foundation

protocol HomeWorkerProtocol {
    func getAll(_ completion: @escaping (Result<[Client], ResponseError>) -> ())
}

class HomeWorker: HomeWorkerProtocol {
    
    func getAll(_ completion: @escaping (Result<[Client], ResponseError>) -> ()) {
        Task {
            do {
                let clients = try await request()
                completion(.success(clients))
            } catch let error as ResponseError {
                completion(.failure(error))
            }
        }
    }
    
    private func request() async throws -> [Client]  {
        guard let url = URL(string: "https://reqres.in/api/users") else {
            throw ResponseError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw ResponseError.invalidData
            }
            
            guard httpResponse.statusCode == 200 else {
                throw ResponseError.httpStatusCodeError(httpResponse.statusCode)
            }
            
            let clients = try JSONDecoder().decode(Users.self, from: data).data.map({ $0 as Client })
            return clients
        } catch let error {
            throw error is DecodingError ? ResponseError.decodeError : ResponseError.invalidUrl
        }
    }
}
