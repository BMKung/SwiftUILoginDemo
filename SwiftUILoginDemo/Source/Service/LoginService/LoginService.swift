//
//  LoginService.swift
//  SwiftUILoginDemo
//
//  Created by Anupap on 25/5/2567 BE.
//

import Foundation

protocol LoginServiceProtocol {
    func login(request: LoginServiceModel.LoginRequest) async throws
}

class LoginService: LoginServiceProtocol {
    func login(request: LoginServiceModel.LoginRequest) async throws {

        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second

        let correctEmail = "test@test.com"
        let correctPassword = "password"

        if request.email == correctEmail && request.password == correctPassword {
            return
        } else {
            throw LoginError.invalidCredentials
        }
    }
}

enum LoginError: LocalizedError {
    case invalidCredentials
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Your email address and/or password is incorrect."
        }
    }
}
