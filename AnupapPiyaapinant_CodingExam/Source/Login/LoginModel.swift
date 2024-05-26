//
//  LoginModel.swift
//  AnupapPiyaapinant_CodingExam
//
//  Created by Anupap on 25/5/2567 BE.
//

import Foundation

enum LoginEmailVerifyResult {
    case success
    case emptyFailure
    case invalidFailure
    
    var description: String {
        switch self {
        case .success:
            return "Success"
        case .emptyFailure:
            return "Email address cannot be empty."
        case .invalidFailure:
            return "Email address is invalid."
        }
    }
}

enum LoginPasswordVerifyResult {
    case success
    case emptyFailure
    
    var description: String {
        switch self {
        case .success:
            return "Success"
        case .emptyFailure:
            return "Password cannot be empty."
        }
    }
}
