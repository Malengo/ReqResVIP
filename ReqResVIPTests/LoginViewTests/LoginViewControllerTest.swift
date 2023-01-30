//
//  LoginViewControllerTest.swift
//  ReqResVIPTests
//
//  Created by Jose Augusto on 26/01/23.
//

import XCTest
@testable import ReqResVIP

final class LoginViewControllerTest: XCTestCase {

    var sut: LoginViewController!
    var interactor: LoginViewInteractorMock!
    var router: LoginRouterMock!
    
    override func setUpWithError() throws {
        sut = LoginViewController()
        interactor = LoginViewInteractorMock()
        router = LoginRouterMock()
    }

    override func tearDownWithError() throws {
        sut = nil
        interactor = nil
        router = nil
    }

    func testViewDidLoadMustCallSetup() {
        //Given
        
        
        //When
        sut.viewDidLoad()
        
        
        //Then
        XCTAssertTrue(sut.interactor is LoginViewInteractor)
        XCTAssertTrue(sut.router is LoginRouter)
    }

    func testButtonLoginActionMustCalledAuthenticateUserInInteractor() {
        //Given
        sut.viewDidLoad()
        sut.interactor = interactor
        
        //When
        sut.mainView.buttonLogin.sendActions(for: .touchUpInside)
        
        //Then
        XCTAssertTrue(interactor.wasAuthenticateUserCalled)
    }
    
    func testSuccessAuthMustCalledRouteToHomeView() {
        //Given
        sut.router = router
        
        //When
        sut.successAuth()
        
        //Then
        XCTAssertTrue(router.wasRouteToHomeViewCalled)
    }

}
