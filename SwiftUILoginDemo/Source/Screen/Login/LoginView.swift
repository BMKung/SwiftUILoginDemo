//
//  LoginView.swift
//  SwiftUILoginDemo
//
//  Created by Anupap on 25/5/2567 BE.
//

import SwiftUI

struct LoginView: View {

    @EnvironmentObject private var navigationManager: NavigationManager
    @StateObject private var viewModel = LoginViewModel()
    @State private var isPasswordVisible = false
    @FocusState private var focusedField: Field?

    private enum Field: Hashable {
        case email
        case password
    }

    var body: some View {
        VStack(spacing: 20) {
            header
            emailTextField
            passwordTextField
            loginButton
            Spacer()
        }
        .id(viewModel.uiResetToken)
        .onAppear() {
            viewModel.reset()
        }
        .onChange(of: viewModel.isLoggedIn) { _, isLoggedIn in
            if isLoggedIn {
                navigationManager.push(.main)
            }
        }
        .onChange(of: focusedField) { old, new in
            if old == .email && new != .email {
                viewModel.validateEmail()
            }
            if old == .password && new != .password {
                viewModel.validatePassword()
            }
        }
        .padding()
        .onTapGesture {
            focusedField = nil
        }
    }

    @ViewBuilder
    var header: some View {
        Text("Login")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.bottom, 30)
    }

    @ViewBuilder
    var emailTextField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Email")
            
            TextField("Enter your email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .focused($focusedField, equals: .email)
                .onChange(of: viewModel.email) {
                    if focusedField == .email {
                        viewModel.validateEmail()
                    }
                }

            if let emailError = viewModel.emailError, focusedField != .email {
                Text(emailError)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }

    @ViewBuilder
    var passwordTextField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Password")

            HStack {
                    if isPasswordVisible {
                        TextField("Enter your password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($focusedField, equals: .password)
                        .onChange(of: viewModel.password) {
                            if focusedField == .password {
                                viewModel.validatePassword()
                            }
                        }
                } else {
                    SecureField("Enter your password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .focused($focusedField, equals: .password)
                        .onChange(of: viewModel.password) {
                            if focusedField == .password {
                                viewModel.validatePassword()
                            }
                        }
                }

                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }

            if let passwordError = viewModel.passwordError, focusedField != .password {
                Text(passwordError)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }

    @ViewBuilder
    var loginButton: some View {
        Button(action: {
            Task {
                await viewModel.login()
            }
        }) {
            HStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.8)
                }
                Text(viewModel.isLoading ? "Logging in..." : "Login")
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(viewModel.isLoginButtonEnabled ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .disabled(!viewModel.isLoginButtonEnabled || viewModel.isLoading)

        if let errorMessage = viewModel.errorMessage {
            Text(errorMessage)
                .font(.caption)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(LoginViewModel())
        .environmentObject(NavigationManager())
}
