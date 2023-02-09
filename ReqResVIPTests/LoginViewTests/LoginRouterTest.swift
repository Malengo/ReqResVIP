//
//  LoginRouterTest.swift
//  ReqResVIPTests
//
//  Created by Jose Augusto on 09/02/23.
//

import XCTest
@testable import ReqResVIP
final class LoginRouterTest: XCTestCase {
    
    var sut: LoginRouter?
    var viewController: UIViewControllerSpy?

    override func setUpWithError() throws {
        viewController = UIViewControllerSpy()
        sut = LoginRouter(viewController: viewController!)
    }

    override func tearDownWithError() throws {
        viewController = nil
        sut = nil
    }

    func testRouteToHomeMustCallPresent() throws {
        //Given
        let expectation = expectation(description: "wait for present")
        
        viewController?.presentCompletionHandler = { viewController, animated, _ in
            XCTAssertTrue(viewController is HomeViewController)
            XCTAssertTrue(animated)
            expectation.fulfill()
        }
        
        //When
        sut?.routeToHomeView()
        
        //Then
        waitForExpectations(timeout: 1)
    }

    func testRouteToAlertDialogMustErrorMessage() {
        //Given
        let messageError = "Failure to get login"
        
        //When
        sut?.routeToAlertDialog(error: messageError)
        
        //Then
        XCTAssertNotNil(messageError)
    }

}
