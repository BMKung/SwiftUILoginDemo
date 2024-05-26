//
//  LoginViewModel.swift
//  AnupapPiyaapinant_CodingExam
//
//  Created by Anupap on 25/5/2567 BE.
//

import Foundation

class LoginViewModel {
    struct Output {
        var loginSuccess: (() -> Void)?
        var loginFailed: ((String) -> Void)?
    }
    
    var service = LoginService()
    var output = Output()
    
    func login(email: String, password: String) {
        service.login(request: LoginServiceModel.LoginRequest(email: email, password: password)) {
            self.output.loginSuccess?()
        } failure: { response in
            self.output.loginFailed?(response.errorMessage)
        }
    }
    
    func verifyEmail(_ value: String?) -> LoginEmailVerifyResult {
        if let email = value, !email.isEmpty {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            if emailPred.evaluate(with: email) {
                return .success
            }
            return .invalidFailure
        }
        return .emptyFailure
    }
    
    func verifyPassword(_ value: String?) -> LoginPasswordVerifyResult {
        if let password = value, !password.isEmpty {
            return .success
        }
        return .emptyFailure
    }
}
