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
            await request()
        }
    }
    
    private func request() async {
        guard let url = URL(string: "https://reqres.in/api/users") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let employer = try JSONDecoder().decode(Users.self, from: data)
            print(employer.data.first)
        } catch let error {
            print(error)
        }
    }
}
