//
//  HomeViewController.swift
//  ReqResVIP
//
//  Created by Jose Augusto on 10/01/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var homeView: HomeView = {
        let view = HomeView()
        return view
    }()
    
    // MARK: - VIP
    var interactor: HomeViewBusinessLogic?
    
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
        interactor = HomeViewInteractor(worker: HomeWorker())
    }
}
