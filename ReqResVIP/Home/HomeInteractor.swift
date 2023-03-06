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

class HomeInteractor: HomeViewBusinessLogic {
    
    var worker: HomeWorkerProtocol?
    var presenter: HomePresentationLogic?
    
    init(worker: HomeWorkerProtocol, presenter: HomePresentationLogic?) {
        self.worker = worker
        self.presenter = presenter
    }
    
    func fecthUsers() {
        worker?.getAll({ result in
            switch result {
            case .success(let clients):
                let response = HomeModel.GetUsers.Response(clients: clients)
                self.presenter?.presentAll(response: response)
            case.failure(let error):
                print(error)
            }
        })
    }
}
