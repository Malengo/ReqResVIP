//
//  HomeViewController.swift
//  ReqResVIP
//
//  Created by Jose Augusto on 10/01/23.
//

import UIKit

protocol HomeDisplayLogic {
    func displayAllUsers(viewModel: HomeModel.GetUsers.ViewModel)
}

class HomeViewController: UIViewController {
    
    lazy var homeView: HomeView = {
        let view = HomeView()
        return view
    }()
    
    // MARK: - VIP
    var interactor: HomeViewBusinessLogic?
    var presenter: HomePresentationLogic?
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVIP()
        interactor?.fecthUsers()
    }
    
    override func loadView() {
        homeView.setupView()
        view = homeView
    }
    
    // MARK: - private Methods
    private func setupVIP() {
        presenter = HomePresenter(view: self)
        interactor = HomeInteractor(worker: HomeWorker(), presenter: presenter)
    }
}

extension HomeViewController: HomeDisplayLogic {
    func displayAllUsers(viewModel: HomeModel.GetUsers.ViewModel) {
        viewModel.clients.forEach({ print($0) })
    }
}
