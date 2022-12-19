//
//  SignUpView.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 14/12/22.
//

import SwiftUI
import Photo_Gallery_With_Firebase_SDK

struct SignUpView: View {
    @ObservedObject var signUpViewModel: SignUpViewModel
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var showAlert: Bool = false
    @FocusState var emailFieldIsFocused: Bool
    @FocusState var passwordFieldIsFocused: Bool
    @FocusState var passwordConfirmFieldIsFocused: Bool
    
    init(signUpViewModel: ISignUpViewModel) {
        self.signUpViewModel = signUpViewModel as! SignUpView.SignUpViewModel
        self.emailFieldIsFocused = false
        self.passwordFieldIsFocused = false
        self.passwordConfirmFieldIsFocused = false
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
                text: $email
            )
            .focused($emailFieldIsFocused)
            .onChange(of: self.email) { _ in }
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.emailAddress)
            .padding(.bottom, 20.0)
            Group {
                SecureField(
                    "Password",
                    text: $password
                )
                .focused($passwordFieldIsFocused)
                .onChange(of: self.password) { _ in }
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 20.0)
                SecureField(
                    "Confirm Password",
                    text: $confirmPassword
                )
                .focused($passwordConfirmFieldIsFocused)
                .onChange(of: self.confirmPassword) { _ in }
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 20.0)
            }
            if self.signUpViewModel.isLoading == true {
                ActivityIndicatorView(color: Color("ButtonBackgroundColor"))
                    .frame(width: 50.0, height: 50.0)
            } else {
                Button("Sign Up", action: {
                    Task {
                        let passwordEqual = self.signUpViewModel.verifyEqualPassword(
                            password: self.password,
                            repassword: self.confirmPassword
                        )
                        if passwordEqual {
                            self.resetFocusField()
                            await self.handleSignUp(username: self.email, password: self.password)
                        }
                    }
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
            }
            Spacer()
            HStack {
                Text("Have an account?")
                    .foregroundColor(.black.opacity(0.7))
                Spacer()
                Button("Sign In", action: self.goToSignInPage)
                    .foregroundColor(Color("ButtonBackgroundColor"))
                    .background(.white)
            }
            .padding(.bottom, 30.0)
        }
        .padding(.horizontal, 20.0)
        .onReceive(
            NotificationCenter.default.publisher(
                for: self.signUpViewModel.showAlertConstant
            )) { status in
                self.showAlert = status.object as! Bool
            }
            .alert(isPresented: self.$showAlert) {
                return self.signUpViewModel.alert
            }
    }
    
    
    func handleSignUp(username: String, password: String) async -> Void {
        let email: Email = Email(email: self.email)
        let password: Password = Password(password: self.password)
        await self.signUpViewModel.signUp(email: email, password: password)
    }
    
    func goToSignInPage() -> Void {
        self.signUpViewModel.goToSignInPage()
    }
    
    func resetFocusField() -> Void {
        self.emailFieldIsFocused = false
        self.passwordFieldIsFocused = false
        self.passwordConfirmFieldIsFocused = false
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(signUpViewModel: SignUpView.SignUpViewModel())
    }
}
