//
//  SwiftUILoginDemoApp.swift
//  SwiftUILoginDemo
//
//  Created by Anupap on 7/10/2568 BE.
//

import SwiftUI

@main
struct SwiftUILoginDemoApp: App {
    @StateObject private var navigationManager = NavigationManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationManager.navigationPath) {
                navigationManager.rootDestination.screen
                    .navigationDestination(for: NavigationDestination.self) { destination in
                        destination.screen
                    }
            }
            .environmentObject(navigationManager)
        }
    }
}
