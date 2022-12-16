//
//  SignInView.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 13/12/22.
//

import SwiftUI
import Photo_Gallery_With_Firebase_SDK

struct SignInView: View {
    var signInViewModel: SignInViewModel
    @State var email: String = ""
    @State var password: String = ""
    @State var showAlert: Bool = false
    @FocusState var emailFieldIsFocused: Bool
    @FocusState var passwordFieldIsFocused: Bool
    
    init(signInViewModel: ISignInViewModel) {
        self.signInViewModel = signInViewModel as! SignInView.SignInViewModel
        self.emailFieldIsFocused = false
        self.passwordFieldIsFocused = false
    }
    
    func showAlert(status: Bool) {
        self.showAlert = status
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
                text: self.$email
            )
            .focused($emailFieldIsFocused)
            .onSubmit {
                let email: Email = Email(email: self.email)
                if self.signInViewModel.validateEmail(email: email) == true {
                    self.signInViewModel.email = self.email
                }
            }
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.bottom, 20.0)
            SecureField(
                "Password",
                text: self.$password
            )
            .focused($passwordFieldIsFocused)
            .onSubmit {
                let password: Password = Password(password: self.password)
                if self.signInViewModel.validatePassword(password: password) == true {
                    self.signInViewModel.password = self.password
                }
            }
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.bottom, 20.0)
            if self.signInViewModel.isLoading == true {
                ActivityIndicatorView(color: Color("ButtonBackgroundColor"))
                    .frame(width: 50.0, height: 50.0)
            } else {
                Button("Sign In", action: {
                    Task {
                        let email: Email = Email(email: self.email)
                        let password: Password = Password(password: self.password)
                        await self.signInViewModel.signIn(email: email, password: password)
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
                Button("Forgot Password?", action: {
                    Task {
                        let email: Email = Email(email: self.email)
                        await self.signInViewModel.forgotPassword(email: email)
                    }
                })
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    maxHeight: 35.0
                )
                .foregroundColor(Color("ButtonBackgroundColor"))
                .background(.white)
            }
            Spacer()
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.black.opacity(0.7))
                Spacer()
                Button("Sign Up", action: self.signInViewModel.goToSignUpPage)
                    .foregroundColor(Color("ButtonBackgroundColor"))
                    .background(.white)
            }
            .padding(.bottom, 30.0)
        }
        .padding(.horizontal, 20.0)
        .onReceive(
            NotificationCenter.default.publisher(for: self.signInViewModel.showAlertConstant)) { status in
                self.showAlert = status.object as! Bool
            }
            .alert(isPresented: self.$showAlert) {
                return self.signInViewModel.alert
            }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(signInViewModel: SignInView.SignInViewModel())
    }
}
