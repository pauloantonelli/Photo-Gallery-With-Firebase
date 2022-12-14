//
//  SignUpView.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 14/12/22.
//

import SwiftUI

struct SignUpView: View {
    @State var username: String = ""
    @State var password: String = ""
    @FocusState var emailFieldIsFocused: Bool
    @FocusState var passwordFieldIsFocused: Bool
    @FocusState var passwordConformFieldIsFocused: Bool
    
    init(emailFieldIsFocused: Bool = false, passwordFieldIsFocused: Bool = false, passwordConformFieldIsFocused: Bool = false) {
        self.emailFieldIsFocused = emailFieldIsFocused
        self.passwordFieldIsFocused = passwordFieldIsFocused
        self.passwordConformFieldIsFocused = self.passwordConformFieldIsFocused
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
            Text("Create your Account")
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
            Group {
                SecureField(
                    "Password",
                    text: $password
                ) {
                    
                }
                .focused($passwordFieldIsFocused)
                .onSubmit {
                    self.validatePassword(password: password)
                }
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 20.0)
                SecureField(
                    "Confirm Password",
                    text: $password
                ) {
                    
                }
                .focused($passwordFieldIsFocused)
                .onSubmit {
                    self.validateConfirmPassword(password: password)
                }
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 20.0)
            }
            Button("Sign Up", action: {
                self.handleSignUp(username: self.username, password: self.password)
            })
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                maxHeight: 35.0
            )
            .foregroundColor(.white)
            .background(Color("ButtonBackgroundColor"))
            .cornerRadius(5.0)
            .padding(.bottom, 10.0)
            Spacer()
            HStack {
                Text("Have an account?")
                    .foregroundColor(.black.opacity(0.7))
                Spacer()
                Button("Sign In", action: self.goToSignIn)
                    .foregroundColor(Color("ButtonBackgroundColor"))
                    .background(.white)
            }
            .padding(.bottom, 30.0)
        }
        .padding(.horizontal, 20.0)
    }
    
    
    func handleSignUp(username: String, password: String) -> Void {
        print("signIn")
    }
    
    func goToSignIn() -> Void {
        
    }
    
    func validateUserName(name: String) -> Void {
        
    }
    
    func validatePassword(password: String) -> Void {
        
    }
    
    func validateConfirmPassword(password: String) -> Void {
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
