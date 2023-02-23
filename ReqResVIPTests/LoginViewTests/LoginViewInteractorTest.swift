//
//  LoginViewInteractorTest.swift
//  ReqResVIPTests
//
//  Created by Jose Augusto on 30/01/23.
//

import XCTest
@testable import ReqResVIP

final class LoginViewInteractorTest: XCTestCase {
    
    var sut: LoginViewInteractor!
    var presenter: LoginViewPresenterMock!
    var worker: LoginAuthWorkerMock!

    override func setUpWithError() throws {
        presenter = LoginViewPresenterMock()
        worker = LoginAuthWorkerMock(loginAuth: LoginAuthAPI())
        sut = LoginViewInteractor(presenter: presenter)
        sut.authWorker = worker
    }

    override func tearDownWithError() throws {
        presenter = nil
        sut = nil
    }

    func testAuthenticateUserSuccessMustCallSuccesAuth() {
        //Given
        let user = LoginUser.Request(user: User(email: "eve.holt@reqres.in", password: "citysli"))
        let ex = expectation(description: "Must called presenter successAuth but dosen't")
        
        worker.makeAuthCompletionHandler = { _, completion in
            completion(.success(true))
            ex.fulfill()
        }
        //When
        sut.authenticateUser(request: user)
        
        //Then
        waitForExpectations(timeout: 1)
        XCTAssertTrue(presenter.wasSuccessAuthCalled)
    }

    func testAuthenticateUserFailureMustCallFailureAuth() {
        //Given
        let user = LoginUser.Request(user: User(email: "teste@test.com", password: "1234"))
        
        let expectation = expectation(description: "Must called presenter failureAuth but dosen't")
        
        worker.makeAuthCompletionHandler = { _, completion in
            completion(.failure(.invalidData))
            expectation.fulfill()
        }
        
        //When
        sut.authenticateUser(request: user)
        
        //Then
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(presenter.wasFailureAuthCalled)
    }

}
