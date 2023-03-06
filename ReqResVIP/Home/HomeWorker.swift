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

class HomeWorker: HomeWorkerProtocol, RequestApiProtocol {
    
    typealias RequestApi = Any
    typealias ResponseApi = [Client]
    var urlRequest: URL?
    var request: URLRequest?
    var data: Data?
    
    // MARK: - RequestApiProtocol
    func validUrl() throws {
        guard let url = Foundation.URL(string: "https://reqres.in/api/users") else {
            throw ResponseError.invalidUrl
        }
        urlRequest = url
    }
    
    func setupRequest(_ requestApi: RequestApi) throws {
        guard let url = urlRequest else { throw ResponseError.invalidUrl }
        var setupRequest = URLRequest(url: url)
        setupRequest.httpMethod = "GET"
        request = setupRequest
    }
    
    func getData(_ completion: ([Client]) -> ()) async throws {
        do {
            let (data, response) = try await URLSession.shared.data(for: request!)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw ResponseError.invalidData
            }
            
            guard httpResponse.statusCode == 200 else {
                throw ResponseError.httpStatusCodeError(httpResponse.statusCode)
            }
            
            let clients = try JSONDecoder().decode(Users.self, from: data).data.map({ $0 as Client })
            completion(clients)
        } catch let error {
            throw error is DecodingError ? ResponseError.decodeError : ResponseError.invalidUrl
        }
    }
    
    // MARK: - HomeWorkerProtocol
    func getAll(_ completion: @escaping (Result<[Client], ResponseError>) -> ()) {
        Task {
            do {
                try await callApi(request: "") { clients in
                    completion(.success(clients))
                }
            } catch let error as ResponseError {
                completion(.failure(error))
            }
        }
    }
}
