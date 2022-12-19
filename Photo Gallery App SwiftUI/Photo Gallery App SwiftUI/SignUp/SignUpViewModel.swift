//
//  SignUpViewModel.swift
//  Photo Gallery App SwiftUI
//
//  Created by Paulo Antonelli on 19/12/22.
//

import SwiftUI
import Photo_Gallery_With_Firebase_SDK

protocol ISignUpViewModel {
    func signUp(email: Email, password: Password) async
    func goToSignInPage() -> Void
    func goToPermissionPage() -> Void
    func validateEmail(email: Email) -> Bool
    func verifyEqualPassword(password: String, repassword: String) -> Bool
    func executeSignUp(email: Email, password: Password) async -> Void
    func showLoading() -> Void
    func hideLoading() -> Void
    func showAlert(title: String, message: String, actionTitle: String) -> Void
    func emitAlertStatus(status: Bool) -> Void
}

extension SignUpView {
    class SignUpViewModel: ISignUpViewModel, ObservableObject {
        let showAlertConstant: NSNotification.Name = NSNotification.Name("SignUpAlert")
        var registerUseCase: IRegisterUseCase?
        @Published var isLoading: Bool = false
        var alert: Alert = Alert(
            title: Text(""),
            message: Text(""),
            dismissButton: .default(Text(""))
        )
        
        init() {
            self.registerUseCase = DependencyInjection.get(IRegisterUseCase.self)
        }
        
        func signUp(email: Email, password: Password) async {
            await self.executeSignUp(email: email, password: password)
        }
        
        func goToSignInPage() -> Void {
            print("goToSignInPage")
        }
        
        func goToPermissionPage() -> Void {
            print("goToPermissionPage")
        }
        
        func validateEmail(email: Email) -> Bool {
            if email.isInvalid {
                self.showAlert(title: "Email is missing", message: "Insert you email on email field")
                return false
            }
            return true
        }
        
        func validatePassword(password: Password) -> Bool {
            if password.isInvalid {
                self.showAlert(title: "Password is missing", message: "Insert your password on the field")
                return false
            }
            return true
        }
        
        func verifyEqualPassword(password: String, repassword: String) -> Bool {
            let result: Bool = password.contains(repassword)
            if result == false {
                self.showAlert(message: "Password are not equal")
            }
            return result
        }
        
        func executeSignUp(email: Email, password: Password) async -> Void {
            let credential: Credential = Credential(
                email: email,
                password: password
            )
            self.showLoading()
            do {
                let user: User? = try await self.registerUseCase?.execute(withCredential: credential).get()
                self.hideLoading()
                guard let safeuser = user else {
                    self.showAlert(message: "User not created")
                    return
                }
                if safeuser.id.isEmpty {
                    self.showAlert(message: "User not created")
                    return
                }
                self.goToPermissionPage()
            } catch {
                self.hideLoading()
                let e = error as! RegisterErrorUseCase
                self.showAlert(message: e.message)
            }
        }
        
        func showLoading() -> Void {
            self.isLoading = true
        }
        
        func hideLoading() -> Void {
            self.isLoading = false
        }
        
        func showAlert(title: String = "Unable to login on account", message: String, actionTitle: String = "I understood") -> Void {
            let alert: Alert = Alert(
                title: Text(title),
                message: Text(message),
                dismissButton: .default(Text(actionTitle))
            )
            self.alert = alert
            self.emitAlertStatus(status: true)
        }
        
        func emitAlertStatus(status: Bool) -> Void {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: self.showAlertConstant, object: status)
            }
        }
    }
}
