//
//  LoginRouter.swift
//  ReqResVIP
//
//  Created by Jose Augusto on 10/01/23.
//

import Foundation
import UIKit

protocol LoginRoutingLogic {
    func routeToHomeView()
    func routeToAlertDialog(error: String)
}

class LoginRouter: LoginRoutingLogic {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func routeToHomeView() {
        DispatchQueue.main.async {
            let homeViewController = HomeViewController()
            homeViewController.modalPresentationStyle = .currentContext
            self.viewController?.present(homeViewController, animated: true)
        }
    }
    
    func routeToAlertDialog(error: String) {
        let alert = UIAlertController(title: "Error ao fazer Login", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Fechar", style: .destructive))
        
        DispatchQueue.main.async {
            self.viewController?.present(alert, animated: true)
        }
    }
}
