//
//  LoginRouterMock.swift
//  ReqResVIPTests
//
//  Created by Jose Augusto on 27/01/23.
//

import Foundation
@testable import ReqResVIP

class LoginRouterMock: LoginRoutingLogic {
    
    var wasRouteToHomeViewCalled: Bool = false
    var wasRouteToAlertDialogCalled: Bool = false
    
    func routeToHomeView() {
        wasRouteToHomeViewCalled = true
    }
    
    func routeToAlertDialog(error: String) {
        wasRouteToAlertDialogCalled = true
    }
}
