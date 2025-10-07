//
//  LoginViewModel.swift
//  SwiftUILoginDemo
//
//  Created by Anupap on 25/5/2567 BE.
//

import Foundation
import SwiftUI

@MainActor
class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var emailError: String?
    @Published var passwordError: String?
    @Published var uiResetToken: UUID = UUID()
    
    private let service: LoginServiceProtocol

    init(service: LoginServiceProtocol = LoginService()) {
        self.service = service
    }
    
    var isLoginButtonEnabled: Bool {
        !email.isEmpty && !password.isEmpty && emailError == nil && passwordError == nil
    }
    
    func login() async {
        guard isLoginButtonEnabled else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let request = LoginServiceModel.LoginRequest(email: email, password: password)
            try await service.login(request: request)
            isLoggedIn = true
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func validateEmail() {
        if email.isEmpty {
            emailError = "Email address cannot be empty."
        } else {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            if emailPred.evaluate(with: email) {
                emailError = nil
            } else {
                emailError = "Email address is invalid."
            }
        }
    }
    
    func validatePassword() {
        if password.isEmpty {
            passwordError = "Password cannot be empty."
        } else {
            passwordError = nil
        }
    }
    
    func reset() {
        email = ""
        password = ""
        isLoggedIn = false
        isLoading = false
        errorMessage = nil
        emailError = nil
        passwordError = nil
        uiResetToken = UUID()
    }
}
