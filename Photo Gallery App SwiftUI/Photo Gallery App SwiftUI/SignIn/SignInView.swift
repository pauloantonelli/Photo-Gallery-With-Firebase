//
//  SignInView.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 13/12/22.
//

import SwiftUI

struct SignInView: View {
    @State var username: String = ""
    @State var password: String = ""
    @FocusState var emailFieldIsFocused: Bool
    @FocusState var passwordFieldIsFocused: Bool
    
    init(emailFieldIsFocused: Bool = false, passwordFieldIsFocused: Bool = false) {
        self.emailFieldIsFocused = emailFieldIsFocused
        self.passwordFieldIsFocused = passwordFieldIsFocused
    }
    
    var body: some View {
        VStack {
            Spacer()
            Image("swift-firebase")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(
                    minWidth: 0.0,
                    maxWidth: .infinity,
                    minHeight: 0.0,
                    maxHeight: 150.0
                )
            Text("Login to your Account")
                .fontWeight(.bold)
                .font(.title3)
                .foregroundColor(.black.opacity(0.7))
                .frame(
                    minWidth: 0.0,
                    maxWidth: .infinity,
                    alignment: .leading
                )
            TextField(
                "Email",
                text: $username
            )
            .focused($emailFieldIsFocused)
            .onSubmit {
                self.validateUserName(name: username)
            }
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.bottom, 20.0)
            SecureField(
                "Password",
                text: $password
            ) {
                self.handleLogin(username: username, password: password)
            }
            .focused($passwordFieldIsFocused)
            .onSubmit {
                self.validatePassword(password: password)
            }
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.bottom, 20.0)
            Button("Sign In", action: self.signIn)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    maxHeight: 35.0
                )
                .foregroundColor(.white)
                .background(Color("ButtonBackgroundColor"))
                .cornerRadius(5.0)
                .padding(.bottom, 10.0)
            
            Button("Forgot Password?", action: self.forgotPassword)
                .frame(
                minWidth: 0,
                maxWidth: .infinity,
                maxHeight: 35.0
            )
            .foregroundColor(Color("ButtonBackgroundColor"))
            .background(.white)
            Spacer()
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.black.opacity(0.7))
                Spacer()
                Button("Sign Up", action: self.goToSignUp)
                .foregroundColor(Color("ButtonBackgroundColor"))
                .background(.white)
            }
            .padding(.bottom, 30.0)
        }
        .padding(.horizontal, 20.0)
    }
    
    func signIn() -> Void {
        print("signIn")
    }
    
    func forgotPassword() -> Void {
        
    }
    
    func goToSignUp() -> Void {
        
    }
    
    func validateUserName(name: String) -> Void {
        
    }
    
    func validatePassword(password: String) -> Void {
        
    }
    
    func handleLogin(username: String, password: String) {
        
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
