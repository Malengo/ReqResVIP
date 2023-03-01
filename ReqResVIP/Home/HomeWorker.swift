//
//  HomeViewWorker.swift
//  ReqResVIP
//
//  Created by Jose Augusto on 28/02/23.
//

import Foundation

protocol HomeWorkerProtocol {
    func getAll()
}

class HomeWorker: HomeWorkerProtocol {
    
    func getAll() {
        Task {
            do {
                try await request()
            } catch let error {
                print(error)
            }
        }
    }
    
    private func request() async throws {
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
            
            let employer = try JSONDecoder().decode(Users.self, from: data)
            
        } catch let error {
            throw error is DecodingError ? ResponseError.decodeError : ResponseError.invalidUrl
        }
    }
}
