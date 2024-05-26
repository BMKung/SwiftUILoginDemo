//
//  LoginService.swift
//  AnupapPiyaapinant_CodingExam
//
//  Created by Anupap on 25/5/2567 BE.
//

import Foundation

class LoginService {
    func login(request: LoginServiceModel.LoginRequest, success: @escaping () -> Void, failure: @escaping (ServiceErrorResponse) -> Void) {
        let correctEmail = "test@gmail.com"
        let correctPassword = "password"
        
        if request.email == correctEmail && request.password == correctPassword {
            success()
        } else {
            failure(ServiceErrorResponse(errorMessage: "Your email address and/or password is incorrect."))
        }
    }
}
