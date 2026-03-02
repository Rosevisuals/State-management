//
//  LoginView.swift
//  State management
//
//  Created by Rose Visuals on 02/03/2026.
//

import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var isLoading = false
    
    func login() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                ///an asynchronous login is simulated  by setting isLoading = true then after a 2 seconds time delay the state is updated with an animation to stop loading and mark the user as logged in
                self.isLoading = false
                self.isLoggedIn = true
            }
        }
    }
}

struct RootView: View {
    //RootView owns the AuthViewModel via the @stateobject
    @StateObject var auth = AuthViewModel() //it needs to conform to the @ObservableObject
    
    var body: some View {
        if auth.isLoggedIn {
            HomeView() // is in another swift file ContentView
        } else {
            LoginView(auth: auth)
        }
    }
}

struct LoginView: View {
    @ObservedObject var auth: AuthViewModel //needs to comform to the @ObservableObject
    
    var body: some View {
        VStack {
            if auth.isLoading {
                ProgressView()
            } else {
                Button("Login") {
                    auth.login() //need to maintain the code syntax whether small letters or capital letters , different text have different meanings #consistent method name
                }
                .frame(width:100, height:50)
                .background(Color.green.opacity(0.5))
                .cornerRadius(10)
                .disabled(auth.isLoading) // the button is disabled while loading
            }
        }
    }
}

#Preview {
    RootView() // have to call the struct with the @stateobject
}
