//
//  LoginRouter.swift
//  ReqResVIP
//
//  Created by Jose Augusto on 10/01/23.
//

import Foundation

protocol LoginRoutingLogic {
    func routeToHomeView()
}

class LoginRouter: LoginRoutingLogic {
    weak var viewController: LoginViewController?
    
    init(viewController: LoginViewController) {
        self.viewController = viewController
    }
    
    func routeToHomeView() {
        DispatchQueue.main.async {
            let vc = HomeViewController()
            vc.modalPresentationStyle = .currentContext
            self.viewController?.present(vc, animated: true)
        }
    }
}
