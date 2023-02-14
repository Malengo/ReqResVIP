//
//  LoginAuthWorkerTest.swift
//  ReqResVIPTests
//
//  Created by Jose Augusto on 13/02/23.
//

import XCTest
@testable import ReqResVIP

final class LoginAuthWorkerTest: XCTestCase {
    
    var sut: LoginAuthWorker?
    
    override func setUpWithError() throws {
        sut = LoginAuthWorker(loginAuth: LoginAuthApiSpy())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testMakeAuthMustReturnedSuccess() throws {
        //Given
        let request = LoadUser.Request(user: User(email: "teste@test.com", password: "12345"))
        let spy = sut?.loginAuth as! LoginAuthApiSpy
        spy.makeAuthCompletionHandler = Result.success(true)
        
        //When
        sut?.makeAuth(user: request) { result  in
            switch result {
            case .success(let test):
                XCTAssertTrue(test)
            default :
                return
            }
        }
        
        //Then
    }
}

class LoginAuthApiSpy: LoginAuthLogic {
    
    var makeAuthCalled = false
    var makeAuthCompletionHandler: ((Result<Bool, ResponseError>))?
    
    func makeAuth(user: LoadUser.Request, completion: @escaping (Result<Bool, ResponseError>) -> Void) {
        makeAuthCalled = true
        completion(makeAuthCompletionHandler!)
    }
}
