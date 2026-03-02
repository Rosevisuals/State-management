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
    @Published var errorMessage: String?
    
    func login(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter your email and password"
            return
        }
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                ///an asynchronous login is simulated  by setting isLoading = true then after a 2 seconds time delay the state is updated with an animation to stop loading and mark the user as logged in
                self.isLoading = false
                if email == "test@gmail.com" && password == "123456"{
                    self.isLoggedIn = true
                }
                else {
                    self.errorMessage = "Invalid credentials"
                }
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
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    var body: some View {
        VStack (spacing: 20) {
            HStack(spacing: 8) {
                Image(systemName: "envelope")
                    .foregroundStyle(.secondary)
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            }
            .padding(12)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            
            HStack(spacing: 8) {
                Image(systemName: "lock")
                    .foregroundStyle(.secondary)
                Group {
                    if isPasswordVisible {
                        TextField("Password", text: $password)
                            .textContentType(.password)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                    } else {
                        SecureField("Password", text: $password)
                            .textContentType(.password)
                    }
                }
                Button(action: { isPasswordVisible.toggle() }) {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
            }
            .padding(12)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            
            if let error = auth.errorMessage {
                Text(error)
                    .font(.footnote)
                    .foregroundStyle(.red)
            }
            
            if auth.isLoading {
                ProgressView()
            } else {
                Button("Login") {
                    auth.login(email: email, password: password) //need to maintain the code syntax whether small letters or capital letters , different text have different meanings #consistent method name
                }
                
                .tint(.white)
                .frame(width:100, height:50)
                .cornerRadius(20)
                .background(Color.green.opacity(1))
                .disabled(auth.isLoading) // the button is disabled while loading
            }
        }
        .padding(20)
    }
}

#Preview {
    RootView() // have to call the struct with the @stateobject
}
