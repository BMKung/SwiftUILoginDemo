//
//  MockLoginService.swift
//  SwiftUILoginDemoTests
//
//  Created by Anupap on 7/10/2568 BE.
//

@testable import SwiftUILoginDemo

struct MockLoginService: LoginServiceProtocol {
    var shouldSucceed: Bool
    var delayNanoseconds: UInt64 = 1_000_000_000

    func login(request: LoginServiceModel.LoginRequest) async throws {
        try await Task.sleep(nanoseconds: delayNanoseconds)
        if !shouldSucceed { throw LoginError.invalidCredentials }
    }
}
