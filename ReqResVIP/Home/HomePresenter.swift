//
//  HomePresenter.swift
//  ReqResVIP
//
//  Created by Jose Augusto on 03/03/23.
//

import Foundation

protocol HomePresentationLogic {
    func presentAll(response: HomeModel.GetUsers.Response)
}

class HomePresenter: HomePresentationLogic {
    var view: HomeDisplayLogic?
    
    init(view: HomeDisplayLogic?) {
        self.view = view
    }
    
    func presentAll(response: HomeModel.GetUsers.Response) {
        let viewModel = HomeModel.GetUsers.ViewModel(clients: response.clients)
        view?.displayAllUsers(viewModel: viewModel)
    }
}
