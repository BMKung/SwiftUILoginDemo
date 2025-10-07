//
//  SwiftUILoginDemoTests.swift
//  SwiftUILoginDemoTests
//
//  Created by Anupap on 7/10/2568 BE.
//

import XCTest
@testable import SwiftUILoginDemo

@MainActor
final class SwiftUILoginDemoTests: XCTestCase {
    var viewModel: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel(
            service: MockLoginService(
                shouldSucceed: true
            )
        )
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testLoginWithValidCredentials() async {
        // Given
        viewModel.email = "test@test.com"
        viewModel.password = "password"
        
        // When
        await viewModel.login()
        
        // Then
        XCTAssertTrue(viewModel.isLoggedIn)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testLoginWithInvalidCredentials() async {
        // Given
        viewModel = LoginViewModel(
            service: MockLoginService(
                shouldSucceed: false,
                delayNanoseconds: 1_000_000_000
            )
        )
        viewModel.email = "invalid@email.com"
        viewModel.password = "wrongpassword"
        
        // When
        await viewModel.login()
        
        // Then
        XCTAssertFalse(viewModel.isLoggedIn)
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    func testEmailValidation() {
        // Given
        let validEmail = "test@test.com"
        let invalidEmail = "invalid-email"
        let emptyEmail = ""
        
        // When & Then
        viewModel.email = validEmail
        viewModel.validateEmail()
        XCTAssertNil(viewModel.emailError)
        
        viewModel.email = invalidEmail
        viewModel.validateEmail()
        XCTAssertNotNil(viewModel.emailError)
        
        viewModel.email = emptyEmail
        viewModel.validateEmail()
        XCTAssertNotNil(viewModel.emailError)
    }
    
    func testPasswordValidation() {
        // Given
        let validPassword = "password"
        let emptyPassword = ""
        
        // When & Then
        viewModel.password = validPassword
        viewModel.validatePassword()
        XCTAssertNil(viewModel.passwordError)
        
        viewModel.password = emptyPassword
        viewModel.validatePassword()
        XCTAssertNotNil(viewModel.passwordError)
    }
    
    func testLoginButtonState() {
        // Given
        viewModel.email = ""
        viewModel.password = ""
        
        // When & Then
        XCTAssertFalse(viewModel.isLoginButtonEnabled)
        
        // When
        viewModel.email = "test@test.com"
        viewModel.password = "password"
        viewModel.validateEmail()
        viewModel.validatePassword()
        
        // Then
        XCTAssertTrue(viewModel.isLoginButtonEnabled)
    }
    
    func testLoginStateReset() {
        // Given
        viewModel.isLoggedIn = true
        viewModel.email = "test@test.com"
        viewModel.password = "password"
        
        // When
        viewModel.reset()
        
        // Then
        XCTAssertFalse(viewModel.isLoggedIn)
        XCTAssertEqual(viewModel.email, "")
        XCTAssertEqual(viewModel.password, "")
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertNil(viewModel.emailError)
        XCTAssertNil(viewModel.passwordError)
    }
}
