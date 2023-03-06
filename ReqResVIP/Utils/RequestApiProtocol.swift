//
//  RequestApiProtocol.swift
//  ReqResVIP
//
//  Created by Jose Augusto on 06/03/23.
//

import Foundation

protocol RequestApiProtocol {
    associatedtype RequestApi
    associatedtype ResponseApi
    func validUrl() throws
    func setupRequest(_ requestApi: RequestApi) throws
    func getData(_ completion: (ResponseApi) -> ()) async throws
    
    var urlRequest: URL? { get }
    var request: URLRequest? { get }
    var data: Data? { get }
}

extension RequestApiProtocol {
    func callApi(request: RequestApi, completion: @escaping (ResponseApi) ->()) async throws {
        try validUrl()
        try setupRequest(request)
        try await getData(completion)
    }
}
