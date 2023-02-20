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
    var mainView: LoginViewMock!
    
    override func setUpWithError() throws {
        sut = LoginViewController()
        interactor = LoginViewInteractorMock()
        router = LoginRouterMock()
        mainView = LoginViewMock()
    }

    override func tearDownWithError() throws {
        sut = nil
        interactor = nil
        router = nil
    }
    
    func testLoadViewMustCallSetUpViewAndSetDelegate() {
        //Given
        sut.mainView = mainView
        
        //When
        sut.loadView()
        
        //Then
        XCTAssertTrue(mainView.wasBuildViewHierachyCalled)
        XCTAssertTrue(mainView.wasSetupConstraintsCalled)
        XCTAssertTrue(mainView.wasAddtionalConfigurationCalled)
        XCTAssertTrue(mainView.wasSetupTextFieldDelegateCalled)
    }

    func testViewDidLoadMustCallSetup() {
        //Given
        
        
        //When
        sut.viewDidLoad()
        
        
        //Then
        XCTAssertTrue(sut?.interactor is LoginViewBusinessLogic)
        XCTAssertTrue(sut?.router is LoginRoutingLogic)
    }
    
    func testViewDidLoadMustCallAddActionInButtonLogin() {
        //Given
        sut.mainView = mainView
        
        //When
        sut.viewDidLoad()
        
        //Then
        XCTAssertTrue(mainView.wasAddActionButtonLoginCalled)
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
    
    func testButtonLoginActionMustCalledVerifyFieldWhenFieldsIsEmpty() {
        //Given
        sut.mainView = mainView
       
        let expectation = expectation(description: "Wait to VerifyFied to be called")
        
        mainView.addActionInButtonLoginCompletionHandler = { target, selector in
            self.mainView.buttonLogin.addTarget(target, action: selector, for: .touchUpInside)
            expectation.fulfill()
            
        }
        
        
        //When
        sut.viewDidLoad()
        mainView.nameTextField.text = nil
        mainView.passwordTextField.text = nil
        mainView.buttonLogin.sendActions(for: .touchUpInside)
        //Then
        waitForExpectations(timeout: 2)
        XCTAssertTrue(mainView.wasVerifyFieldCalled)
    }
    
    func testSuccessAuthMustCalledRouteToHomeView() {
        //Given
        sut.router = router
        
        //When
        sut.successAuth()
        
        //Then
        XCTAssertTrue(router.wasRouteToHomeViewCalled)
    }
    
    func testFailureAuthMustCalledRouteToAlertDialog() {
        //Given
        let error = ResponseError.invalidData
        sut.router = router
        
        //When
        sut.failureAuth(error.description)
        
        //Then
        XCTAssertTrue(router.wasRouteToAlertDialogCalled)
    }
    
    func testTextFieldDidBeginEditing() {
        //Given
        let textField = sut.mainView.nameTextField
        textField.becomeFirstResponder()
        
        //When
        sut.textFieldDidBeginEditing(textField)
        
        //Then
        XCTAssertEqual(textField.layer.borderColor, UIColor.black.cgColor)
    }
    
    func testTextFieldShouldBeginEditing() {
        //Given
        let textField = sut.mainView.nameTextField
        textField.becomeFirstResponder()
        
        //When
        let _ = sut.textFieldShouldBeginEditing(textField)
        
        //Then
        XCTAssertEqual(textField.layer.borderColor, UIColor.black.cgColor)
    }

}
