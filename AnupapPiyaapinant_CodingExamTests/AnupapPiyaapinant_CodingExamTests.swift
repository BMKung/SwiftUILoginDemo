//
//  AnupapPiyaapinant_CodingExamTests.swift
//  AnupapPiyaapinant_CodingExamTests
//
//  Created by Anupap on 25/5/2567 BE.
//

import XCTest
@testable import AnupapPiyaapinant_CodingExam

final class AnupapPiyaapinant_CodingExamTests: XCTestCase {
    var viewModel: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func tests_onLoginSuccess() {
        //given
        let expectation = self.expectation(description: "Login failed")
        
        let email = "test@gmail.com"
        let password = "password"
        
        viewModel.output.loginSuccess = {
            expectation.fulfill()
        }
        
        //when
        viewModel.login(email: email, password: password)
        
        //then
        waitForExpectations(timeout: 1.0)
    }
    
    func tests_onLoginErrorWrongEmail() {
        //given
        let expectation = self.expectation(description: "Login failed")
        
        let email = "wrong@gmail.com"
        let password = "password"
        
        viewModel.output.loginFailed = { _ in
            expectation.fulfill()
        }
        
        //when
        viewModel.login(email: email, password: password)
        
        //then
        waitForExpectations(timeout: 1.0)
    }
    
    func tests_onLoginErrorWrongPassword() {
        //given
        let expectation = self.expectation(description: "Login failed")
        
        let email = "test@gmail.com"
        let password = "wrongPassword"
        
        viewModel.output.loginFailed = { _ in
            expectation.fulfill()
        }
        
        //when
        viewModel.login(email: email, password: password)
        
        //then
        waitForExpectations(timeout: 1.0)
    }
    
    func tests_onLoginErrorWrongEmailAndPassword() {
        //given
        let expectation = self.expectation(description: "Login failed")
        
        let email = "wrong@gmail.com"
        let password = "wrongPassword"
        
        viewModel.output.loginFailed = { _ in
            expectation.fulfill()
        }
        
        //when
        viewModel.login(email: email, password: password)
        
        //then
        waitForExpectations(timeout: 1.0)
    }
    
    func tests_onVerifyEmailSuccess() {
        //given
        let email = "test@gmail.com"
        
        //when
        let verifyResult = viewModel.verifyEmail(email)
        
        //then
        XCTAssertEqual(verifyResult, LoginEmailVerifyResult.success)
    }
    
    func tests_onVerifyEmailFailedInvalid() {
        //given
        let email = "test"
        
        //when
        let verifyResult = viewModel.verifyEmail(email)
        
        //then
        XCTAssertEqual(verifyResult, LoginEmailVerifyResult.invalidFailure)
    }
    
    func tests_onVerifyEmailFailedEmpty() {
        //given
        let email = ""
        
        //when
        let verifyResult = viewModel.verifyEmail(email)
        
        //then
        XCTAssertEqual(verifyResult, LoginEmailVerifyResult.emptyFailure)
    }
    
    func tests_onVerifyPasswordSuccess() {
        //given
        let password = "password"
        
        //when
        let verifyResult = viewModel.verifyPassword(password)
        
        //then
        XCTAssertEqual(verifyResult, LoginPasswordVerifyResult.success)
    }
    
    func tests_onVerifyPasswordFailedEmpty() {
        //given
        let password = ""
        
        //when
        let verifyResult = viewModel.verifyPassword(password)
        
        //then
        XCTAssertEqual(verifyResult, LoginPasswordVerifyResult.emptyFailure)
    }
}

