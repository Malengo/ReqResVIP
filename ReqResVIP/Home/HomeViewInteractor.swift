//
//  HomeViewInteractor.swift
//  ReqResVIP
//
//  Created by Jose Augusto on 28/02/23.
//

import Foundation

protocol HomeViewBusinessLogic {
    func fecthUsers()
}

class HomeViewInteractor: HomeViewBusinessLogic {
    
    var worker: HomeWorkerProtocol?
    init(worker: HomeWorkerProtocol) {
        self.worker = worker
    }
    
    func fecthUsers() {
        worker?.getAll({ result in
            switch result {
            case .success(let clients):
                print(clients)
            case.failure(let error):
                print(error)
            }
        })
    }
}
