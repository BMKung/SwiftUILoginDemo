//
//  MainView.swift
//  SwiftUILoginDemo
//
//  Created by Anupap on 25/5/2567 BE.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    
    var body: some View {
        VStack(spacing: 30) {
            // Welcome Message
            VStack(spacing: 16) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.green)
                
                Text("Welcome!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("You have successfully logged in.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            // Logout Button
            Button(action: {
                navigationManager.backToRoot()
            }) {
                HStack {
                    Image(systemName: "arrow.left.circle")
                    Text("Logout")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    MainView()
        .environmentObject(NavigationManager())
}
