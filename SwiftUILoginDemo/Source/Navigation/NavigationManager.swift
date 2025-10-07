//
//  NavigationManager.swift
//  SwiftUILoginDemo
//
//  Created by Anupap on 7/10/2568 BE.
//

import Foundation
import SwiftUI

// MARK: - Navigation Destination
enum NavigationDestination: Hashable {
    case login
    case main

    @ViewBuilder
    var screen: some View {
        switch self {
        case .login: LoginView()
        case .main: MainView()
        }
    }
}

// MARK: - Navigation Manager
@MainActor
class NavigationManager: ObservableObject {
    @Published var rootDestination: NavigationDestination = .login
    @Published var navigationPath: [NavigationDestination] = []

    func push(_ destination: NavigationDestination) {
        navigationPath.append(destination)
    }

    func backToRoot(_ destination: NavigationDestination? = nil) {
        if let newRootDestination = destination {
            rootDestination = newRootDestination
        }
        navigationPath = []
    }

    func goBack() {
        navigationPath.removeLast()
    }
}
