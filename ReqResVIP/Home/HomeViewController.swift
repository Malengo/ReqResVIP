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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        homeView.setupView()
        view = homeView
    }
}
