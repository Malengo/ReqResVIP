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
            let vc = HomeViewController()
            vc.modalPresentationStyle = .currentContext
            self.viewController?.present(vc, animated: true)
        }
    }
    
    func routeToAlertDialog(error: String) {
        print(error)
    }
}
